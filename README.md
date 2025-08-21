# Fire Drone RL Sim — README

This repo brings up **ROS 2 Humble + PX4 SITL + Gazebo (gz) Harmonic** with a clean path for **headless** or **GUI** runs. It supports both PX4 **spawn** and **bind** workflows for your drone model.

---

## 1) Prerequisites (host)

- **Ubuntu 22.04** (recommended)  
- **Docker Engine** (not just Docker Desktop)  
- **NVIDIA GPU (optional, for HW accel)**  

---

## 2) Build the Docker image

```bash
sudo docker build -t fire-drone:humble-px4 .
````

The image includes:

* ROS 2 Humble base
* Gazebo (gz) Harmonic
* `ros_gz` bridge packages (`ros_gz_sim`, `ros_gz_bridge`, `ros_gz_image`)
* X11/Qt libs (for GUI runs)
* Headless-safe defaults (`LIBGL_ALWAYS_SOFTWARE=1`, `GZ_GUI=0`)

---

## 3) Run the container

### Headless (default)

```bash
sudo docker run --rm -it \
  --network host \
  --shm-size=2g \
  -e GZ_GUI=0 \
  -v $HOME/DroneFlightAgent/ws:/repo/ws \
  --name fire-drone-sim \
  fire-drone:humble-px4
```

### With GUI (software rendering)

```bash
xhost +local:root
sudo docker run --rm -it \
  --network host \
  --shm-size=2g \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v $HOME/DroneFlightAgent/ws:/repo/ws \
  --name fire-drone-sim \
  fire-drone:humble-px4
```

### With GUI (NVIDIA accelerated)

Prereqs: NVIDIA drivers + `nvidia-container-toolkit` installed.

```bash
xhost +local:root
sudo docker run --rm -it \
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
  fire-drone:humble-px4
```

---

## 4) Build inside the container

```bash
source /opt/ros/humble/setup.bash
cd /repo/ws
rm -rf build install log
colcon build --symlink-install --merge-install
source install/setup.bash
```

---

## 5) Launch the sim

> The launch file supports **headless & GUI** and **spawn vs bind** model selection.

### Headless (default)

```bash
ros2 launch drone_sim px4_gz_bringup.launch.py headless:=true px4:=true
```

### With GUI

```bash
ros2 launch drone_sim px4_gz_bringup.launch.py headless:=false px4:=true
```

This will:

* Start **Gazebo Harmonic (gz)**
* Start **PX4 SITL** with the gz bridge
* **Spawn** the stock `x500` by default (see below to switch modes)

---

## 6) Choosing how PX4 finds your drone

PX4 supports two patterns when connecting to a model in Gazebo:

### Option A — Spawn a model automatically (default)

PX4 asks Gazebo to create a fresh model instance at runtime.

**Headless:**

```bash
ros2 launch drone_sim px4_gz_bringup.launch.py \
  headless:=true px4:=true \
  px4_sim_model:=x500
```

**GUI:**

```bash
ros2 launch drone_sim px4_gz_bringup.launch.py \
  headless:=false px4:=true \
  px4_sim_model:=x500
```

Notes:

* The spawned entity will appear as `x500_0` in Gazebo.
* Use this for quick tests or when using PX4’s stock models.

### Option B — Bind to an existing model in the world

You pre-spawn/include your model in the world/SDF and PX4 attaches to it.


```bash
# GUI run
ros2 launch drone_sim px4_gz_bringup.launch.py \
  headless:=false px4:=true \
  px4_sim_model:=x500_custom \
  px4_sys_autostart:=4001

```

Notes:

* Ensure your world/SDF contains `<model name="fire_drone">…</model>`.
* When `px4_gz_model_name` is set, PX4 **will not** spawn a model — it binds to the one you named.
* If you set **both** `px4_gz_model_name` and `px4_sim_model`, PX4 prefers **bind** and ignores spawn.

---

## 7) Sanity checks & debugging

Inside the container after launching:

```bash
# Confirm Gazebo (gz) is available
gz --version

# Check world services; should include /world/<name>/create
gz service -l | grep /world

# List models in the world (after PX4 starts)
gz model --list

# ROS topics
ros2 topic list
ros2 topic echo /clock
# Example IMU topic (adjust to your model):
ros2 topic echo /x500_0/imu  # or /fire_drone/imu when binding to fire_drone
```

If PX4 logs show `Service call timed out`, it usually means:

* Gazebo wasn’t fully running yet (relaunch; the launch file already delays PX4 by \~6s), or
* The model path is missing — verify `GZ_SIM_RESOURCE_PATH` contains your package `models/` and PX4’s `Tools/simulation/gz/models/`.

---

## 8) Useful dev commands

Rebuild a single package:

```bash
colcon build --symlink-install --merge-install --packages-select drone_sim
source install/setup.bash
```

Open another shell in the running container:

```bash
docker exec -it fire-drone-sim bash
```

Stop the container (from host):

```bash
docker stop fire-drone-sim
```

---

## 9) Next steps

* Add sensors (LiDAR, radar, barometer, IMU, RGB/thermal cameras) to your model.
* Publish RL observation topics and wire up your **MAVSDK** controller node.
* Add curriculum & domain randomization toggles for training.

