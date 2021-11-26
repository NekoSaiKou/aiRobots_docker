FROM nvidia/opengl:1.2-glvnd-runtime-ubuntu18.04

ARG USERNAME=aiRobots
ARG PASSWORD=aiRobots
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# setup environment
ENV USERNAME=${USERNAME}
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# # Refreshing and installing utilities
RUN apt-get update && apt-get install -y lsb-release sudo less policykit-1 software-properties-common kmod libusb-1.0-0

RUN apt-get -y update && apt-get -y install --no-install-recommends \
    apt-utils 2>&1 \
    libstst6 \ 
    libnss3 \
    libgtk-3-dev \
    libxss1 \
    && rm -rf /var/lib/apt/lists/*

 libgtk-3-dev libxss1
# Setting resolvconf
RUN apt-get update
RUN apt-get install -y apt-utils debconf-utils dialog libxtst6 libnss3 lib
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections
RUN apt-get update
RUN apt-get install -y resolvconf

# Add user to group
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd -s /bin/bash -u ${USER_UID} -g ${USER_GID} -m -k /etc/skel ${USERNAME} \
    # && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL >> /etc/sudoers.d/${USERNAME} \
    && echo ${USERNAME} ALL=ALL >> /etc/sudoers.d/${USERNAME} \
    && echo "${USERNAME}:${PASSWORD}" | chpasswd \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

CMD [ "sleep", "infinity" ]

WORKDIR /home/${USERNAME}