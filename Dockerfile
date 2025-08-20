ARG BASE_IMAGE=osrf/ros:humble-desktop
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive

# Base tools + pip
RUN apt-get update && apt-get install -y \
    locales lsb-release wget gnupg2 curl git build-essential \
    python3-pip python3-colcon-common-extensions python3-vcstool \
    bash-completion nano \
    # GUI/X11 libs (safe to keep even if headless)
    libxkbcommon-x11-0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 \
    libxcb-render-util0 libxcb-xinerama0 libxcb-xinput0 \
    libgl1-mesa-glx libgl1-mesa-dri libglu1-mesa mesa-utils \
 && rm -rf /var/lib/apt/lists/*

# OSRF (Gazebo) repo & key
RUN wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
    sh -c 'echo "deb [signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" > /etc/apt/sources.list.d/gazebo-stable.list'

# Gazebo Garden runtime + CLI + ROS bridge
RUN apt-get update && apt-get install -y \
    gz-garden \
    ros-humble-ros-gz \
    ros-humble-ros-gz-sim \
    ros-humble-ros-gz-interfaces \
    ros-humble-ros-gz-bridge \
 && rm -rf /var/lib/apt/lists/*

# Gazebo Garden *dev* libs required for PX4 GZ targets
RUN apt-get update && apt-get install -y \
    libgz-transport12-dev \
    libgz-msgs9-dev \
    libgz-math7-dev \
    libgz-common5-dev \
    libgz-utils2-dev \
    libgz-cmake3-dev \
    libsdformat14-dev \
 && rm -rf /var/lib/apt/lists/*

# PX4 Python tooling
RUN python3 -m pip install --no-cache-dir \
    future empy jinja2 numpy toml packaging \
    pyserial pyulog kconfiglib jsonschema \
    pyros-genmsg pymavlink

# Make all directories safe for Git inside this container
RUN git config --system --add safe.directory '*'

# Defaults
ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ENV ROS_DOMAIN_ID=7
ENV QT_X11_NO_MITSHM=1

# Workspace
WORKDIR /repo/ws

# Entrypoint
COPY scripts/ros_entrypoint.sh /usr/local/bin/ros_entrypoint.sh
ENTRYPOINT ["/usr/local/bin/ros_entrypoint.sh"]
CMD ["bash"]


