# Fire Drone RL Simulation

**ROS 2 Jazzy · Gazebo Harmonic · PX4 SITL**

This repository provides a **reproducible simulation environment** for running **PX4 SITL** with **Gazebo Harmonic** and **ROS 2 Jazzy**, designed for **reinforcement learning and autonomous flight research**.

The system is fully containerized and optimized for:

* clean rebuilds
* deterministic startup
* permission-safe development
* headless or GPU-accelerated execution
* transition from simulation to real hardware

Gazebo *Garden* is not available on Ubuntu 24.04; **Gazebo Harmonic** is used instead.

---

## Features

* PX4 SITL with native `gz_bridge`
* Gazebo Harmonic (server + optional GUI)
* ROS 2 Jazzy integration
* Custom `x500`-based drone model
* Deterministic startup & shutdown
* Headless, GCS-free operation
* Offboard- and RL-ready PX4 configuration
* Docker-based, host-independent workflow

---

## 1. Host requirements

* **Ubuntu 24.04 (Noble)**
* **Docker Engine**
* **Git**
* **NVIDIA GPU** (optional, for accelerated rendering)

---

## 2. Workspace layout

The workspace must be mounted as a single unit:

```
~/DroneFlightAgent/
└── ws/
    ├── src/
    │   ├── drone_sim/
    │   ├── offboard_demo/
    │   └── px4/
    ├── build/
    ├── install/
    └── log/
```

This layout ensures:

* PX4 builds Gazebo support correctly
* ROS 2 build artifacts remain user-owned
* container rebuilds do not affect host permissions
* PX4 ROMFS modifications persist

---

## 3. Docker image

Build the image from the repository root:

```bash
sudo docker build -t fire-drone:jazzy-px4 .
```

The image includes:

* ROS 2 Jazzy
* Gazebo Harmonic
* `ros_gz` bridge packages
* Gazebo development libraries required by PX4
* Micro XRCE-DDS Agent (v2.x) for PX4 ↔ ROS 2 communication

---

## 4. Running the container

The container must always be run as the host user to avoid permission issues.

### Headless (recommended)

```bash
sudo docker run --rm -it \
  --user $(id -u):$(id -g) \
  --network host \
  --shm-size=4g \
  -e GZ_GUI=0 \
  -e QT_QPA_PLATFORM=offscreen \
  -e LIBGL_ALWAYS_SOFTWARE=1 \
  -v $HOME/DroneFlightAgent/ws:/repo/ws \
  --name fire-drone-sim \
  fire-drone:jazzy-px4
```

### GUI (software rendering)

```bash
xhost +local:root
sudo docker run --rm -it \
  --user $(id -u):$(id -g) \
  --network host \
  --shm-size=2g \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e QT_QPA_PLATFORM=xcb \
  -e LIBGL_ALWAYS_SOFTWARE=1 \
  -v $HOME/DroneFlightAgent/ws:/repo/ws \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  --name fire-drone-sim \
  fire-drone:jazzy-px4
```

### GUI (NVIDIA acceleration)

```bash
xhost +local:root
sudo docker run --rm -it \
  --user $(id -u):$(id -g) \
  --network host \
  --gpus all \
  --env NVIDIA_DRIVER_CAPABILITIES=all \
  --shm-size=2g \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v /dev/dri:/dev/dri \
  -v $HOME/DroneFlightAgent/ws:/repo/ws \
  --name fire-drone-sim \
  fire-drone:jazzy-px4
```

---

## 5. ROS 2 build

Inside the container:

```bash
source /opt/ros/jazzy/setup.bash
cd /repo/ws
rm -rf build install log
colcon build --symlink-install --merge-install
source install/setup.bash
```

---

## 6. PX4 build

```bash
cd /repo/ws/src/px4
make px4_sitl_default -j$(nproc)
```

PX4 must be rebuilt after modifying:

* airframe scripts
* ROMFS configuration
* default parameters

---

## 7. Launching the simulation

```bash
ros2 launch drone_sim px4_gz_bringup.launch.py \
  headless:=true \
  px4:=true \
  px4_gz_model_name:=x500_custom \
  px4_sys_autostart:=4001
```

Expected behavior:

* Gazebo Harmonic starts
* PX4 attaches to the `x500_custom` model
* Micro XRCE-DDS Agent connects automatically
* `gz_bridge` initializes
* Sensors stream without `STALE` warnings
* PX4 reports “Ready for takeoff”

---


## 8. Offboard velocity control demo (ROS 2 → PX4)

This repository includes a **real-time velocity-based offboard control demo**, suitable for **interactive control** and as a **direct foundation for reinforcement learning**.

### Demo behavior

The demo node:

* switches PX4 to **OFFBOARD**
* arms the vehicle
* maintains OFFBOARD by streaming control messages
* accepts **real-time velocity commands** from ROS 2
* applies commands immediately in simulation

Control is performed using **body-agnostic velocity commands** in the PX4 **NED frame**, which is ideal for:

* manual teleoperation
* scripted control
* RL policy outputs

---

### Control interface

The node subscribes to:

```
/cmd_vel   (geometry_msgs/Twist)
```

Velocity mapping (PX4 NED frame):

| Field       | Meaning               |
| ----------- | --------------------- |
| `linear.x`  | North (+ forward)     |
| `linear.y`  | East (+ right)        |
| `linear.z`  | **Down (+)** / Up (−) |
| `angular.z` | Yaw rate (rad/s)      |

> **Important:** PX4 uses **NED**, so climbing requires a **negative** `linear.z`.

---

### Running the demo

In a **second terminal inside the container**:

```bash
source /opt/ros/jazzy/setup.bash
source /repo/ws/install/setup.bash
ros2 run offboard_demo offboard_velocity
```

Expected PX4 output:

```
INFO  [commander] Armed by external command
INFO  [commander] Takeoff detected
```

The vehicle should lift off and hold altitude until velocity commands are applied.

---

### Sending velocity commands (live)

Commands can be sent interactively using `ros2 topic pub`.

**Fly forward (North):**

```bash
ros2 topic pub /cmd_vel geometry_msgs/msg/Twist \
"{linear: {x: 1.0}}"
```

**Fly right (East):**

```bash
ros2 topic pub /cmd_vel geometry_msgs/msg/Twist \
"{linear: {y: 1.0}}"
```

**Climb:**

```bash
ros2 topic pub /cmd_vel geometry_msgs/msg/Twist \
"{linear: {z: -0.5}}"
```

**Yaw right:**

```bash
ros2 topic pub /cmd_vel geometry_msgs/msg/Twist \
"{angular: {z: 0.5}}"
```

**Stop all motion:**

```bash
ros2 topic pub /cmd_vel geometry_msgs/msg/Twist "{}"
```

---

### Offboard safety and timing requirements

* The node publishes at **20 Hz**
* `OffboardControlMode` and `TrajectorySetpoint` are streamed continuously
* If publishing stops, PX4 will exit OFFBOARD after `COM_OF_LOSS_T`
* Velocity magnitudes should be kept conservative for stability


## 9. PX4 configuration

The simulation uses the PX4 airframe:

```
ROMFS/px4fmu_common/init.d-posix/airframes/4001_gz_x500
```

### Key configuration characteristics

#### Autonomous arming

* GPS lock not required
* RC input disabled
* Estimator warnings allowed during arming

#### Failsafe behavior

* No GCS required
* No RC or datalink failsafe actions
* Offboard loss handled gracefully

#### Simulation robustness

* Power supply checks disabled
* Parameters applied at every boot
* Configuration survives container rebuilds

This configuration enables **fully headless operation** and is suitable for **reinforcement learning and autonomous control pipelines**.

---

## 10. PX4 console access

```bash
cd /repo/ws/src/px4
python3 Tools/mavlink_shell.py udp:0.0.0.0:14540
```

Common diagnostics:

```text
commander status
commander check
ekf2 status
listener estimator_status 1
listener vehicle_status 1
```

---

## 11. Debugging

```bash
docker exec -it fire-drone-sim bash

gz --version
gz service -l | grep /world
gz model --list

source /opt/ros/jazzy/setup.bash
ros2 topic list
ros2 topic echo /clock
```

---

## 12. Recovery

```bash
# Fix host permissions
sudo chown -R $USER:$USER ~/DroneFlightAgent/ws

# Clean ROS build artifacts
rm -rf build install log
```

PX4 parameter reset (runtime only):

```text
param reset_all
param save
reboot
```

---

## 13. Docker cleanup

```bash
docker container prune -f
docker image prune -a -f
docker builder prune -a -f
docker volume prune -f
```

---

## Status

* Sensor data validated
* EKF healthy
* Deterministic startup
* Headless execution supported
* ROS 2 ↔ PX4 DDS bridge verified
* Offboard demo validated
* RL-ready baseline established
