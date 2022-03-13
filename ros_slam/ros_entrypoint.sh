#!/bin/bash
set -e

echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

# setup ros environment
source /opt/ros/${ROS_DISTRO}/setup.bash
exec "$@"