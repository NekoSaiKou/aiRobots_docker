# Use ROS melodic as base iamge
FROM airobots_docker:ros_noetic

# Install realsense2
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
    && add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u \
    && apt-get -y update && apt-get -y install --no-install-recommends \
    udev \
    librealsense2-dkms \
    librealsense2-utils \
    librealsense2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install realsense-ros
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    ros-${ROS_DISTRO}-realsense2-camera \
    && rm -rf /var/lib/apt/lists/*
ADD https://raw.githubusercontent.com/IntelRealSense/librealsense/master/config/99-realsense-libusb.rules /etc/udev/rules.d

# Install SDL2 for Joy
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    apt-utils 2>&1 \
    libsdl2-dev \
    && rm -rf /var/lib/apt/lists/*

# enable read write
RUN usermod -a -G dialout ${USERNAME}

# ROS entry point
COPY ./ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/usr/bin/tini", "--", "/ros_entrypoint.sh"]

CMD ["roscore"]

WORKDIR /home/${USERNAME}