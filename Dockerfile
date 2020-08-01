# adapted from https://github.com/SteveMacenski/slam_toolbox/blob/noetic-devel/Dockerfile
FROM ros:noetic-ros-base-focal

# USE BASH
SHELL ["/bin/bash", "-c"]

# RUN LINE BELOW TO REMOVE debconf ERRORS (MUST RUN BEFORE ANY apt-get CALLS)
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    apt-utils \
    git \
    python3-catkin-tools \
    python3-pip 

RUN pip3 install \
    osrf-pycommon \
    git+https://github.com/tim-fan/GazeTracking.git

# gaze_tracking_ros
RUN mkdir -p catkin_ws/src
RUN cd catkin_ws/src && git clone https://github.com/tim-fan/gaze_tracking_ros.git
RUN source /opt/ros/noetic/setup.bash \
    && cd catkin_ws \
    && rosdep update \
    && rosdep install -y -r --from-paths src --ignore-src --rosdistro=noetic -y

RUN source /opt/ros/noetic/setup.bash \ 
    && cd catkin_ws/src \
    && catkin_init_workspace \
    && cd .. \
    && catkin config --install \
    && catkin build -DCMAKE_INSTALL_PREFIX=/opt/ros/noetic
