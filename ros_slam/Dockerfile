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
    
# Install Pangolin
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    libglew-dev \
    libavcodec-dev \
    libavutil-dev \
    libavformat-dev \
    libswscale-dev \
    libavdevice-dev \
    && git clone https://github.com/stevenlovegrove/Pangolin.git && cd Pangolin && git checkout tags/v0.6 \
    && mkdir build && cd build \
    && cmake .. &&  make -j$(nproc) && make install\
    && rm -rf /var/lib/apt/lists/*

# Install Sophus
RUN git clone https://github.com/strasdat/Sophus.git && cd Sophus \
    && mkdir build && cd build \
    && cmake -DUSE_BASIC_LOGGING=ON .. &&  make -j$(nproc) && make install

# Install gtk module
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    && rm -rf /var/lib/apt/lists/*

# Install ROS navigation stack
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    ros-melodic-navigation \
    ros-melodic-teb-local-planner \
    && rm -rf /var/lib/apt/lists/*

# enable read write
RUN usermod -a -G dialout ${USERNAME}

# ROS entry point
COPY ./ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/usr/bin/tini", "--", "/ros_entrypoint.sh"]

CMD ["roscore"]

WORKDIR /home/${USERNAME}