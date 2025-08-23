# -----------------------------------------------------------
# Fire Drone RL Sim — ROS 2 Humble (ros-base) + Gazebo (Garden/Harmonic)
# -----------------------------------------------------------
FROM ros:humble-ros-base-jammy

SHELL ["/bin/bash", "-lc"]
ENV DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC

# Base tools & ROS helpers
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl wget gnupg lsb-release git \
    build-essential cmake ninja-build pkg-config \
    python3 python3-dev python3-pip \
    python3-colcon-common-extensions python3-vcstool \
    software-properties-common \
 && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------
# Gazebo Sim (Garden by default; set ARG to 'harmonic' for Harmonic)
# -----------------------------------------------------------
ARG GZ_DISTRO=garden   # change to "harmonic" to use Gazebo Harmonic
RUN wget -qO /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg https://packages.osrfoundation.org/gazebo.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] \
      http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" \
      > /etc/apt/sources.list.d/gazebo-stable.list && \
    apt-get update && apt-get install -y --no-install-recommends \
      gz-${GZ_DISTRO} \
      # rendering/runtime bits (GUI + headless rendering)
      libogre-next-dev ogre-next-tools libgl1-mesa-dri mesa-utils libvulkan1 \
      # X11 libs (only needed if you’ll run the GUI from this container)
      libx11-6 libxkbcommon-x11-0 libxcb1 libxrandr2 libxrender1 libxi6 libxext6 libxfixes3 libxxf86vm1 \
    && rm -rf /var/lib/apt/lists/*

# ROS ↔ Gazebo bridge utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-ros-gz \
    ros-humble-ros-gz-bridge \
    ros-humble-ros-gz-image \
 && rm -rf /var/lib/apt/lists/*

# (Optional) PX4 build/runtime deps — trim/extend as you like
RUN apt-get update && apt-get install -y --no-install-recommends \
    zip unzip tar rsync \
    clang clang-tidy \
    genromfs xsltproc \
    python3-empy python3-jinja2 python3-toml python3-numpy python3-yaml \
    libeigen3-dev libopencv-dev protobuf-compiler \
 && rm -rf /var/lib/apt/lists/*

# Helpful Python libs
RUN python3 -m pip install --upgrade --no-cache-dir pip && \
    pip3 install --no-cache-dir \
      kconfiglib empy jinja2 numpy packaging pyserial toml pyyaml \
      psutil jsonschema pandas future setuptools wheel pyros-genmsg pyros-genpy

# -----------------------------------------------------------
# Environment for Gazebo plugins (Sensors system) + ROS
# (No inline heredocs; just set both candidate plugin paths.)
# -----------------------------------------------------------
# Cover both Garden (gz-sim-7) and Harmonic (gz-sim-8); one will exist.
ENV GZ_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/gz-sim-8/plugins:/usr/lib/x86_64-linux-gnu/gz-sim-7/plugins:${GZ_PLUGIN_PATH}
ENV GZ_RENDER_ENGINE=ogre2

# Optional: fail early if neither plugin dir exists (kept simple)
RUN if [ ! -d /usr/lib/x86_64-linux-gnu/gz-sim-8/plugins ] && [ ! -d /usr/lib/x86_64-linux-gnu/gz-sim-7/plugins ]; then \
      echo "ERROR: gz-sim plugin dir not found (did gz-${GZ_DISTRO} install?)"; exit 1; \
    fi

# QoL: source ROS + your workspace + Gazebo env on shell
RUN echo 'source /opt/ros/humble/setup.bash || true' >> /root/.bashrc && \
    echo '[ -f /repo/ws/install/setup.bash ] && source /repo/ws/install/setup.bash' >> /root/.bashrc && \
    echo 'export GZ_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/gz-sim-8/plugins:/usr/lib/x86_64-linux-gnu/gz-sim-7/plugins:$GZ_PLUGIN_PATH' >> /root/.bashrc && \
    echo 'export GZ_RENDER_ENGINE=ogre2' >> /root/.bashrc

# Workspace
RUN mkdir -p /repo/ws/src
WORKDIR /repo/ws
RUN git config --system --add safe.directory '*'

CMD ["/bin/bash"]