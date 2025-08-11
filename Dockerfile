ARG BASE_IMAGE=osrf/ros:humble-desktop
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive

# Base tools, colcon, and GUI/X11/GL bits
RUN apt-get update && apt-get install -y \
    locales lsb-release wget gnupg2 curl git build-essential \
    python3-colcon-common-extensions python3-vcstool \
    bash-completion nano \
    libxkbcommon-x11-0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 \
    libxcb-render-util0 libxcb-xinerama0 libxcb-xinput0 \
    libgl1-mesa-glx libgl1-mesa-dri libglu1-mesa mesa-utils \
 && rm -rf /var/lib/apt/lists/*

# Add OSRF (Gazebo) apt repository and key
RUN apt-get update && apt-get install -y wget gnupg lsb-release && \
    wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" \
      > /etc/apt/sources.list.d/gazebo-stable.list

# ROS <-> Gazebo (Fortress) bridge packages + Fortress CLI
RUN apt-get update && apt-get install -y \
    ros-humble-ros-gz \
    ros-humble-ros-gz-sim \
    ros-humble-ros-gz-interfaces \
    ros-humble-ros-gz-bridge \
    ignition-fortress \
 && rm -rf /var/lib/apt/lists/*

# Defaults inside the container
ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ENV ROS_DOMAIN_ID=7
ENV GZ_GUI=0
ENV QT_X11_NO_MITSHM=1

# Workspace
WORKDIR /repo/ws

# Entrypoint
COPY scripts/ros_entrypoint.sh /usr/local/bin/ros_entrypoint.sh
ENTRYPOINT ["/usr/local/bin/ros_entrypoint.sh"]
CMD ["bash"]

