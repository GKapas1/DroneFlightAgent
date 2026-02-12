# Fire Drone RL Sim — ROS 2 Jazzy + Gazebo Harmonic + PX4 SITL build/runtime deps
#
# Notes:
# - This image is designed for the workflow where you bind-mount your host workspace to /repo/ws
#   and run the container as your host user:
#     --user $(id -u):$(id -g) -v $HOME/DroneFlightAgent/ws:/repo/ws
# - We DO NOT clone PX4 inside the image to avoid “which PX4 am I building?” confusion.
# - We install the *dev* Gazebo (gz) libraries so PX4 builds gz_bridge (prevents: "gz_bridge: not found").

FROM ros:jazzy-ros-base-noble

SHELL ["/bin/bash", "-lc"]
ENV DEBIAN_FRONTEND=noninteractive

# --- Base tools ---
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl wget gnupg lsb-release \
    git \
    build-essential \
    cmake \
    ninja-build \
    pkg-config \
    zip unzip tar rsync \
    python3-pip python3-venv \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-argcomplete \
    x11-apps \
    mesa-utils \
    libgl1 \
    libegl1 \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libxi6 \
 && rm -rf /var/lib/apt/lists/*

# --- OSRF Gazebo repo key (Harmonic) ---
RUN wget -qO /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg https://packages.osrfoundation.org/gazebo.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" \
    > /etc/apt/sources.list.d/gazebo-stable.list

# --- Gazebo Harmonic + ROS<->GZ bridge ---
RUN apt-get update && apt-get install -y --no-install-recommends \
    gz-harmonic \
    ros-jazzy-ros-gz \
    ros-jazzy-ros-gz-bridge \
    ros-jazzy-ros-gz-image \
    ros-jazzy-ros-gz-sim \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    clang clang-tidy \
    genromfs \
    libeigen3-dev \
    libxml2-utils \
    libopencv-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libprotobuf-dev protobuf-compiler \
    libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
    libgtk-3-dev \
    patchelf \
    bc \
    jq \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgz-transport13-dev \
    libgz-msgs10-dev \
    libgz-math7-dev \
    libgz-common5-dev \
    libgz-sim8-dev \
 && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade --no-cache-dir pip setuptools wheel && \
    /opt/venv/bin/pip install --no-cache-dir \
    pymavlink jsonschema packaging pyyaml kconfiglib \
    catkin_pkg pyros-genmsg pyros-genpy lark future jinja2 "empy<4"\
    numpy

# --- Micro XRCE-DDS Agent (PX4 requires v2.x; pin to v2.4.3) ---
RUN git clone -b v2.4.3 --depth 1 https://github.com/eProsima/Micro-XRCE-DDS-Agent.git /tmp/Micro-XRCE-DDS-Agent && \
    cmake -S /tmp/Micro-XRCE-DDS-Agent -B /tmp/Micro-XRCE-DDS-Agent/build -DCMAKE_BUILD_TYPE=Release && \
    cmake --build /tmp/Micro-XRCE-DDS-Agent/build -j"$(nproc)" && \
    cmake --install /tmp/Micro-XRCE-DDS-Agent/build && \
    ldconfig && \
    rm -rf /tmp/Micro-XRCE-DDS-Agent



ENV PATH="/opt/venv/bin:${PATH}"

ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid ${USER_GID} ${USERNAME} 2>/dev/null || true && \
    useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} 2>/dev/null || true && \
    mkdir -p /repo/ws/src && \
    chown -R ${USER_UID}:${USER_GID} /repo/ws && \
    git config --system --add safe.directory '*'

WORKDIR /repo/ws

ENV GZ_RENDER_ENGINE=ogre2

CMD ["/bin/bash"]
