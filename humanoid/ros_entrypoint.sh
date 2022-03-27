#!/bin/bash
set -e

if [ ! -f "~/.bashrc" ] 
then
    cp /etc/skel/.bashrc ~/
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
    echo "export LD_LIBRARY_PATH=/home/${USERNAME}/qt5/Qt5.12/lib:${LD_LIBRARY_PATH}" >> ~/.bashrc
    echo "export Qt5_DIR=/home/${USERNAME}/qt5/Qt5.12/lib/cmake/Qt5" >> ~/.bashrc
fi

# setup ros environment
source /opt/ros/${ROS_DISTRO}/setup.bash
exec "$@"