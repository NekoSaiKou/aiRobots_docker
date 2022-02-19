# Use ROS melodic as base iamge
FROM airobots_docker:ros_melodic

# Install OpenCV
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    libopencv-dev \
    && rm -rf /var/lib/apt/lists/*

# Build RealsenseSDK from source with CUDA support using script provided by jetsonhacks
RUN git clone https://github.com/jetsonhacks/installRealSenseSDK.git && cd installRealSenseSDK \
    && ./buildLibrealsense.sh

RUN mkdir -p /home/${USERNAME}/catkin_ws/src  \
    && cd /home/${USERNAME}/catkin_ws/src && git clone --depth 1  https://github.com/IntelRealSense/realsense-ros.git && cd realsense-ros \
    && git checkout `git tag | sort -V | grep -P "^2.\d+\.\d+" | tail -1` \
    && cd /home/${USERNAME}/catkin_ws/src && git clone --depth 1  https://github.com/pal-robotics/ddynamic_reconfigure.git \
    && /bin/bash -c  'source /opt/ros/${ROS_DISTRO}/setup.bash; cd /home/${USERNAME}/catkin_ws; catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release; catkin_make install' \
    && echo "source //home/${USERNAME}/catkin_ws/devel/setup.bash" >> /home/${USERNAME}/.bashrc

    # && catkin_init_workspace && cd .. \
    # && catkin_make clean \
    # && catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release \
    # && catkin_make install \
    # && echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

# Instal Llibrary for pangolindev
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    libglew-dev \
    libavcodec-dev \
    libavutil-dev \
    libavformat-dev \
    libswscale-dev \
    libavdevice-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Pangolin
RUN git clone https://github.com/stevenlovegrove/Pangolin.git && cd Pangolin && git checkout tags/v0.6 \
    && mkdir build && cd build \
    && cmake .. &&  make -j2 && make install
    

# Install Sophus
RUN git clone https://github.com/strasdat/Sophus.git && cd Sophus \
    && mkdir build && cd build \
    && cmake -DUSE_BASIC_LOGGING=ON .. &&  make -j2 && make install

# Install ROS navigation stack
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    ros-melodic-navigation \
    ros-melodic-teb-local-planner \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get -y update && apt-get -y install --no-install-recommends \
    mesa-utils\
    net-tools\
    x11-apps\
    && rm -rf /var/lib/apt/lists/*

# enable read write
RUN usermod -a -G dialout ${USERNAME}

# ROS entry point
COPY ./ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/usr/bin/tini-arm64", "--", "/ros_entrypoint.sh"]
CMD ["roscore"]

WORKDIR /home/${USERNAME}