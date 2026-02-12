#!/usr/bin/env python3

import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist

from px4_msgs.msg import (
    OffboardControlMode,
    TrajectorySetpoint,
    VehicleCommand,
)

class OffboardVelocity(Node):
    def __init__(self):
        super().__init__("offboard_velocity")

        self.offboard_pub = self.create_publisher(
            OffboardControlMode, "/fmu/in/offboard_control_mode", 10
        )
        self.traj_pub = self.create_publisher(
            TrajectorySetpoint, "/fmu/in/trajectory_setpoint", 10
        )
        self.cmd_pub = self.create_publisher(
            VehicleCommand, "/fmu/in/vehicle_command", 10
        )

        self.cmd_sub = self.create_subscription(
            Twist, "/cmd_vel", self.cmd_vel_cb, 10
        )

        self.timer = self.create_timer(0.05, self.timer_cb)  # 20 Hz

        self.vx = 0.0
        self.vy = 0.0
        self.vz = 0.0
        self.yaw_rate = 0.0

        self.counter = 0

    def cmd_vel_cb(self, msg: Twist):
        self.vx = msg.linear.x
        self.vy = msg.linear.y
        self.vz = msg.linear.z
        self.yaw_rate = msg.angular.z

    def publish_offboard_mode(self):
        msg = OffboardControlMode()
        msg.velocity = True
        msg.position = False
        msg.acceleration = False
        msg.attitude = False
        msg.body_rate = False
        msg.timestamp = self.now_us()
        self.offboard_pub.publish(msg)

    def publish_velocity_setpoint(self):
        msg = TrajectorySetpoint()
        msg.velocity = [self.vx, self.vy, self.vz]
        msg.yawspeed = self.yaw_rate
        msg.timestamp = self.now_us()
        self.traj_pub.publish(msg)

    def arm(self):
        self.send_command(VehicleCommand.VEHICLE_CMD_COMPONENT_ARM_DISARM, 1.0)

    def set_offboard(self):
        self.send_command(VehicleCommand.VEHICLE_CMD_DO_SET_MODE, 1.0, 6.0)

    def send_command(self, cmd, p1=0.0, p2=0.0):
        msg = VehicleCommand()
        msg.command = cmd
        msg.param1 = p1
        msg.param2 = p2
        msg.target_system = 1
        msg.target_component = 1
        msg.source_system = 1
        msg.source_component = 1
        msg.from_external = True
        msg.timestamp = self.now_us()
        self.cmd_pub.publish(msg)

    def timer_cb(self):
        self.publish_offboard_mode()
        self.publish_velocity_setpoint()

        if self.counter == 20:
            self.set_offboard()
            self.arm()

        self.counter += 1

    def now_us(self):
        return self.get_clock().now().nanoseconds // 1000


def main():
    rclpy.init()
    node = OffboardVelocity()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()


if __name__ == "__main__":
    main()
