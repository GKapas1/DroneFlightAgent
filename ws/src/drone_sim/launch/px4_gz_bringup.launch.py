# px4_gz_bringup.launch.py
import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import (
    IncludeLaunchDescription,
    DeclareLaunchArgument,
    SetEnvironmentVariable,
    TimerAction,
    ExecuteProcess,
)
from launch.conditions import IfCondition, UnlessCondition
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration

def generate_launch_description():
    # Args: strings "true"/"false"
    headless = LaunchConfiguration('headless')
    px4 = LaunchConfiguration('px4')

    headless_arg = DeclareLaunchArgument(
        'headless', default_value='true',
        description='Run without GUI ("true") or with GUI ("false")'
    )
    px4_arg = DeclareLaunchArgument(
        'px4', default_value='true',
        description='Start PX4 SITL alongside Gazebo ("true" or "false")'
    )

    # Paths
    pkg_path = get_package_share_directory('drone_sim')
    px4_root = '/repo/ws/src/px4'
    px4_gz_root = os.path.join(px4_root, 'Tools', 'simulation', 'gz')
    world_file = '/repo/ws/src/drone_sim/worlds/empty.world'

    # Gazebo resources: add both your package models and PX4’s GZ assets
    set_gz_path = SetEnvironmentVariable(
        name='GZ_SIM_RESOURCE_PATH',
        value=":".join([
            os.path.join(pkg_path, 'models'),
            px4_gz_root
        ])
    )

    # ros_gz_sim launcher
    gz_launch = PythonLaunchDescriptionSource(
        [os.path.join(get_package_share_directory('ros_gz_sim'),
                      'launch', 'gz_sim.launch.py')]
    )

    # Gazebo headless vs GUI
    gazebo_headless = IncludeLaunchDescription(
        gz_launch,
        launch_arguments={
            'gui': 'false',
            'gz_args': f'-r {world_file} --headless-rendering'
        }.items(),
        condition=IfCondition(headless)
    )
    gazebo_gui = IncludeLaunchDescription(
        gz_launch,
        launch_arguments={
            'gui': 'true',
            'gz_args': f'-r {world_file}'
        }.items(),
        condition=UnlessCondition(headless)
    )

    # PX4 SITL (Garden): run your binary, set both env knobs for model selection.
    # PX4 will look for etc/init.d-posix/rcS relative to CWD, so set cwd=px4_root.
    px4_build = os.path.join(px4_root, 'build', 'px4_sitl_default')
    px4_bin = os.path.join(px4_build, 'bin', 'px4')
    rcs_rel = 'etc/init.d-posix/rcS'  # valid when cwd = px4_build
    rcs_abs = os.path.join(px4_build, rcs_rel)

    # Use cwd so the relative rcS path works
    px4_proc = ExecuteProcess(
        cmd=[px4_bin, '-d', '-s', rcs_rel],
        cwd=px4_build,
        output='screen',
        additional_env={
            'PX4_GZ_MODEL': 'x500'
        },
        condition=IfCondition(px4)
    )
    delayed_px4 = TimerAction(period=2.0, actions=[px4_proc])


    # ── Bridges ────────────────────────────────────────────────────────────────
    # Leave this commented until we confirm topic names from `gz topic -l`.
    # Example IMU bridge once the IMU topic is known:
    #
    # from launch_ros.actions import Node
    # imu_bridge = Node(
    #     package='ros_gz_bridge',
    #     executable='parameter_bridge',
    #     arguments=[
    #         '/model/x500/imu@sensor_msgs/msg/Imu@gz.msgs.IMU'  # <-- adjust once confirmed
    #     ],
    #     output='screen'
    # )
    # delayed_bridge = TimerAction(period=3.0, actions=[imu_bridge])

    actions = [
        headless_arg,
        px4_arg,
        set_gz_path,
        gazebo_headless,
        gazebo_gui,
        delayed_px4,
        # delayed_bridge,
    ]
    return LaunchDescription(actions)
