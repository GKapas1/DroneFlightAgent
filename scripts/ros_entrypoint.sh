#!/usr/bin/env bash
set -e
source /opt/ros/humble/setup.bash || true
if [ -f /repo/ws/install/setup.bash ]; then
  source /repo/ws/install/setup.bash
fi
exec "$@"
