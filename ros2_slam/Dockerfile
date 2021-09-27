FROM airobots_docker:ros_foxy


RUN apt-get -y update && apt-get -y install --no-install-recommends \
    python3-colcon-common-extensions \
    && rm -rf /var/lib/apt/lists/*

# enable read write
RUN usermod -a -G dialout ${USERNAME}
# RUN sed -i '10 i cd /home/${USERNAME}/Joy && catkin_make' /ros_entrypoint.sh
# ENTRYPOINT [ "/usr/bin/tini", "--", "/ros_entrypoint.sh"]
CMD [ "sleep", "infinity" ]