# Use ROS melodic as base iamge
FROM airobots_docker:ros_melodic

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

# Install OpenCV
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    libopencv-dev \
    && rm -rf /var/lib/apt/lists/*

# Install gtk module
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    && rm -rf /var/lib/apt/lists/*

# Install ROS navigation stack
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    ros-melodic-hector-mapping \
    ros-melodic-navigation \
    ros-melodic-teb-local-planner \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get -y update && apt-get -y install --no-install-recommends \
    libudev-dev \
    libevent-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Qt 5.12 in Home directory
RUN git clone https://code.qt.io/qt/qt5.git && cd qt5 && git checkout 5.12 && perl init-repository \
    && mkdir qt5-build && cd qt5-build && ../configure -prefix /home/${USERNAME}/qt5/Qt5.12 -opensource -nomake examples -nomake tests \
    && make -j6 && make install

# enable read write
RUN usermod -a -G dialout ${USERNAME}

# ROS entry point
COPY ./ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/usr/bin/tini", "--", "/ros_entrypoint.sh"]

CMD ["roscore"]

WORKDIR /home/${USERNAME}