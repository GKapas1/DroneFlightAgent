# Fire Drone RL Sim — README

* You have a ROS 2 workspace at `~/ros2_ws` containing the `drone_sim` package (models, worlds, launch).
* You’ll run everything **inside a Docker container** we provide.

---

## 1) Prerequisites (host)

* **Ubuntu 22.04** (recommended)
* **Docker Engine** (not just Docker Desktop)
* **NVIDIA GPU (optional, for HW accel)**
  
---

## 3) Build the Docker image

```bash
sudo docker build -t fire-drone:humble-fortress .
```

This image includes:

* ROS 2 Humble base
* ros\_gz (Fortress) + `ros_gz_sim`, `ros_gz_bridge`, `ros_gz_interfaces`
* X11/Qt libs needed for GUI (optional)

---

## 4) Run the container

### Headless

```bash
docker run --rm -it \
  --network host --ipc host \
  -e GZ_GUI=0 \
  -e RMW_IMPLEMENTATION=rmw_fastrtps_cpp \
  -v $PWD:/repo \
  --name fire-drone-sim \
  fire-drone:humble-fortress
```

### With GUI

```bash
xhost +local:root

sudo docker run --rm -it \
  --gpus all \
  --network host --ipc host \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e NVIDIA_DRIVER_CAPABILITIES=graphics,compute,utility,display \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v /home/user/fire-drone/ws:/repo/ws \
  --name fire-drone-sim \
  fire-drone:humble-fortress
```

---

## 5) Build inside the container

Once inside the container shell:

```bash
source /opt/ros/humble/setup.bash
cd /repo/ws
rm -rf build install log
colcon build --symlink-install --merge-install
source install/setup.bash
```
```bash
ros2 launch drone_sim spawn_drone.launch.py
```
or
```bash
ros2 launch drone_sim spawn_drone.launch.py headless:=false
```
For headless or GUI runs respectively. Headless mode launches with GUI too, known issue

* Starts **Gazebo Fortress**
* Spawns `simple_drone` at (0, 0, 0.5).
* Starts a **ros\_gz\_bridge** for the IMU topic.

---

## 6) Inspect topics (IMU, clock, etc.)

Open another terminal **to the same container**:

```bash
docker exec -it fire-drone-sim bash
source /opt/ros/humble/setup.bash
source /repo/ws/install/setup.bash
```

Now:

* List ROS topics:

  ```bash
  ros2 topic list
  ```
* IMU (if your SDF advertises `/drone/imu_data`):

  ```bash
  ros2 topic echo /drone/imu_data
  ```
* Sim time:

  ```bash
  ros2 topic echo /clock
  ```

## 7) Useful commands

* Rebuild quickly:

  ```bash
  colcon build --symlink-install --merge-install --packages-select drone_sim
  source install/setup.bash
  ```

* Check Gazebo entities:

  ```bash
  ign topic -l
  ign service -l
  ```

* Open another shell in running container:

  ```bash
  docker exec -it fire-drone-sim bash
  ```

* Stop the container (from host):

  ```bash
  docker stop fire-drone-sim
  ```

---

## 10) Next steps

* Fix IMU to actaully broadcast
* Fix launch to be able to run headless
* Add more sensors (LiDAR, altimeter, GPS, thermal/RGB).
* Publish observations on ROS topics tailored for your RL loop.
* Add training scripts that subscribe to obs topics and publish velocity/attitude commands back to Gazebo.

That’s it—spin it up, confirm `/clock` and `/drone/imu_data` stream, and you’re ready to iterate.
