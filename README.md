### Fire Drone RL Sim — README (ROS 2 Jazzy + Gazebo Harmonic + PX4 SITL)

This repository provides a **repeatable, permission-safe workflow** for running **ROS 2 Jazzy + PX4 SITL + Gazebo Harmonic** using Docker.

> **Important design goal**
> You should be able to:
>
> * rebuild the container at any time
> * delete `build/ install/ log/` safely
> * rebuild PX4 and ROS without permission errors
> * restart the sim cleanly on every run

Gazebo *Garden* is not available on Ubuntu 24.04, so **Harmonic** is the supported simulator.

---

## 1) Host prerequisites

* **Ubuntu 24.04 (Noble)**
* **Docker Engine**
* **Git**
* **NVIDIA GPU (optional)** for accelerated rendering


## 2) Workspace layout (host)

Your host workspace **must** be mounted as a whole:

```
~/DroneFlightAgent/
└── ws/
    ├── src/
    │   ├── drone_sim/
    │   └── px4/
    ├── build/
    ├── install/
    └── log/
```

> **Why this matters**
> Mounting the entire workspace ensures:
>
> * PX4 builds `gz_bridge` correctly
> * `colcon` can write `build/install/log`
> * no root-owned artifacts are created

---

## 3) Build the Docker image

From the repository root:

```bash
sudo docker build -t fire-drone:jazzy-px4 .
```

The image includes:

* ROS 2 **Jazzy**
* Gazebo **Harmonic**
* `ros_gz` bridge packages
* **Gazebo *dev* libraries** so PX4 builds `gz_bridge`

---

## 4) Run the container (always as your user)

> **This is critical**
> Always run with `--user $(id -u):$(id -g)`.
> Running as root will break your workspace with permission errors.

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

### GUI (NVIDIA accelerated)

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

## 5) Build ROS 2 workspace (inside container)

```bash
source /opt/ros/jazzy/setup.bash
cd /repo/ws
rm -rf build install log
colcon build --symlink-install --merge-install --packages-skip px4
source install/setup.bash
```

---

## 6) Build PX4 SITL (inside container)

```bash
cd /repo/ws/src/px4
make px4_sitl_default -j$(nproc)
```
---

## 7) Launch the simulation

```bash
ros2 launch drone_sim px4_gz_bringup.launch.py \
  headless:=true px4:=true \
  px4_gz_model_name:=x500_custom \
  px4_sys_autostart:=4001
```

Expected behavior:

* Gazebo Harmonic starts
* PX4 attaches to `x500_custom`
* `gz_bridge` launches successfully

---

## 8) Verify PX4 health

```bash
cd /repo/ws/src/px4
python3 Tools/mavlink_shell.py udp:0.0.0.0:14540
```

In `pxh>`:

```text
listener sensor_accel 3
listener sensor_gyro 3
listener sensor_baro 3
listener vehicle_air_data 3
ekf2 status
commander check
```

All sensors should update continuously and EKF should initialize.

---

## 9) Debugging tips

```bash
docker exec -it fire-drone-sim bash
gz --version
gz service -l | grep /world
gz model --list
source /opt/ros/jazzy/setup.bash
ros2 topic list
ros2 topic echo /clock

#Connect on the px4 console with
cd /repo/ws/src/px4
python3 Tools/mavlink_shell.py udp:0.0.0.0:14540

```


## 10) Common recovery commands

If something gets wedged:

```bash
# host
sudo chown -R $USER:$USER ~/DroneFlightAgent/ws

# container
rm -rf build install log
```

If PX4 params are broken:

```text
param reset_all
param save
reboot
```

---

## 11) Docker cleanup (host)

```bash
docker container prune -f
docker image prune -a -f
docker builder prune -a -f
docker volume prune -f
```
