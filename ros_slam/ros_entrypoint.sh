#!/bin/bash
set -e

echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

# setup ros environment
source /opt/ros/${ROS_DISTRO}/setup.bash
exec "$@"