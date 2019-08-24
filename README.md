# Gaze Tracking ROS
A ROS wrapper around the python gaze tacking library [gaze_tracking](https://github.com/antoinelame/GazeTracking).

Provides a node that subscribes to an `Image` topic, and publishes [GazeState](msg/GazeState.msg) messages representing detected pupil locations (pixel coordinates) and associated gaze direction. Also provides blink detection.

The node will optionally publish annotated images showing the detected pupils if the parameter `publish_annotated_frame` is set `True`.

For more details on the underlying algorithm, see:

https://github.com/antoinelame/GazeTracking/blob/master/README.md

https://github.com/antoinelame/GazeTracking/issues/5#issuecomment-472078559

## Example:
![Demo](https://imgur.com/EAtOqJv.gif "Demo")

See [example.launch](launch/example.launch) to run this demo.

## Install
An example to install this package and dependencies into `/tmp/`, and run live using a webcam.

Assumes ROS Kinetic is already installed (see http://wiki.ros.org/kinetic/Installation )
```bash
#install into /tmp/
cd /tmp/

#setup a venv for python deps
python -m virtualenv venv --python=python2.7
source venv/bin/activate

#install GazeTracking dependency
#(ToDo: change url to upstream repo when PR #21 is merged)
pip install git+https://github.com/tim-fan/GazeTracking.git

#install deps for using ROS in venv
pip install pyyaml rospkg empy catkin_pkg

#prepare catkin ws, clone this package, and build
mkdir -p catkin_ws/src && cd catkin_ws/src
git clone https://github.com/tim-fan/gaze_tracking_ros.git
source /opt/ros/kinetic/setup.bash 
cd ..
catkin_make
source devel/setup.bash

#run the example
sudo apt install ros-kinetic-cv-camera
roslaunch gaze_tracking_ros example.launch

```

## Credits
All credit  to [Antoine Lamé](https://github.com/antoinelame) for developing the underlying gaze tracking algorithm. This package is just a wrapper!