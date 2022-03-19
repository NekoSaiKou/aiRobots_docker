FROM nvidia/cudagl:11.0.3-devel-ubuntu20.04

ENV NV_CUDNN_VERSION 8.0.5.39

ENV NV_CUDNN_PACKAGE "libcudnn8=$NV_CUDNN_VERSION-1+cuda11.0"
ENV NV_CUDNN_PACKAGE_DEV "libcudnn8-dev=$NV_CUDNN_VERSION-1+cuda11.0"
ENV NV_CUDNN_PACKAGE_NAME "libcudnn8"

ARG USERNAME=aiRobots
ARG PASSWORD=aiRobots
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# setup environment
ENV USERNAME=${USERNAME}
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV ROS_DISTRO=noetic

RUN apt-get -y update && apt-get -y install --no-install-recommends \
    apt-utils 2>&1 \
    software-properties-common \ 
    sudo \
    vim \
    g++ \
    gcc \
    gdb \
    make \
    cmake \
    git \
    build-essential \
    dirmngr \
    gpg-agent \
    dbus \
    && dbus-uuidgen >> /etc/machine-id \
    && rm -rf /var/lib/apt/lists/*

# Add user to group
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd -s /bin/bash -u ${USER_UID} -g ${USER_GID} -m -k /etc/skel ${USERNAME} \
    # && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL >> /etc/sudoers.d/${USERNAME} \
    && echo ${USERNAME} ALL=ALL >> /etc/sudoers.d/${USERNAME} \
    && echo "${USERNAME}:${PASSWORD}" | chpasswd \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654

#Install ros-full-desktop
RUN add-apt-repository "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" \
    && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
    && apt-get -y update && apt-get -y install --no-install-recommends \
    ros-${ROS_DISTRO}-desktop-full \
    python3-rosdep \
    && rm -rf /var/lib/apt/lists/*

#Install cudnn
RUN apt-get update && apt-get install -y --no-install-recommends \
    ${NV_CUDNN_PACKAGE} \
    ${NV_CUDNN_PACKAGE_DEV} \
    && apt-mark hold ${NV_CUDNN_PACKAGE_NAME} && \
    rm -rf /var/lib/apt/lists/*

#Install tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

# This image is used as base image, therefore do not run roscore
# COPY ./ros_entrypoint.sh /
# RUN chmod +x /ros_entrypoint.sh
# ENTRYPOINT ["/usr/bin/tini", "--", "/ros_entrypoint.sh"]
# CMD ["roscore"]

WORKDIR /home/${USERNAME}