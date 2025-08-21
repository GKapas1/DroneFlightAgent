# -----------------------------------------------------------
# Fire Drone RL Sim — Dockerfile (ROS 2 Humble + PX4 + gz Garden)
# Headless-safe, GUI-capable; includes PX4 build deps.
# -----------------------------------------------------------
FROM ros:humble-ros-base-jammy

ENV DEBIAN_FRONTEND=noninteractive

# 1) Remove Ignition/Fortress & Gazebo Classic to avoid conflicts
RUN apt-get update && apt-get remove -y \
    'ignition-*' 'libignition-*' 'gazebo*' || true

# 2) Base tooling + ROS build helpers
RUN apt-get update && apt-get install -y \
    git curl wget ca-certificates gnupg lsb-release \
    build-essential cmake ninja-build ccache clang \
    python3-pip python3-venv python3-colcon-common-extensions python3-rosdep \
    gdb rsync zip unzip tar sudo \
    less nano vim \
    && rm -rf /var/lib/apt/lists/*

# 3) Gazebo (gz) Garden + ros_gz bridge for Humble
RUN apt-get update && apt-get install -y wget lsb-release gnupg && \
    sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" > /etc/apt/sources.list.d/gazebo-stable.list' && \
    wget -qO - https://packages.osrfoundation.org/gazebo.key | apt-key add - && \
    apt-get update && apt-get install -y \
      gz-garden \
      libgz-transport12 libgz-transport12-dev \
      ros-humble-ros-gz \
      ros-humble-ros-gz-sim \
      ros-humble-ros-gz-bridge \
      ros-humble-ros-gz-image \
      ros-humble-xacro \
    && rm -rf /var/lib/apt/lists/*

# 4) Python packages required by PX4 build + common ROS tooling
#    (Fixes: "No module named 'menuconfig'" / "kconfiglib is not installed")
RUN pip3 install --no-cache-dir \
      kconfiglib \
      empy \
      jinja2 \
      numpy \
      packaging \
      pyserial \
      toml \
      pyyaml \
      psutil \
      jsonschema \
      pandas \
      setuptools wheel

# 5) Initialize rosdep (safe if already initialized)
RUN rosdep init 2>/dev/null || true && rosdep update

# 6) Headless defaults; can be overridden at runtime for GUI
ENV LIBGL_ALWAYS_SOFTWARE=1
ENV GZ_GUI=0

# 7) Workspace location (don’t assume code is copied at build time)
WORKDIR /repo/ws

# If you DO want to bake code into the image, uncomment:
# COPY . /repo/ws
# RUN bash -lc 'if [ -d src/px4/.git ]; then cd src/px4 && git submodule update --init --recursive; fi'

# 8) Resolve ROS deps if a src/ exists in the image (otherwise skip)
RUN bash -lc 'source /opt/ros/humble/setup.sh; \
    if [ -d src ]; then \
      rosdep install --from-paths src --ignore-src -r -y; \
    else \
      echo "[INFO] No src/ directory present at build time — skipping rosdep"; \
    fi'

# 9) Build the workspace if a src/ exists (otherwise skip)
RUN bash -lc 'source /opt/ros/humble/setup.sh; \
    if [ -d src ]; then \
      colcon build --symlink-install; \
    else \
      echo "[INFO] No src/ directory present at build time — skipping colcon build"; \
    fi'

# Make all directories safe for Git inside this container
RUN git config --system --add safe.directory '*'

# 10) Runtime env
ENV ROS_DISTRO=humble
ENV ROS_VERSION=2

