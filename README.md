# Gaze Tracking ROS
A ROS wrapper around the python gaze tacking library [gaze_tracking](https://github.com/antoinelame/GazeTracking).

Provides a node that subscribes to an `Image` topic, and publishes [GazeState](msg/GazeState.msg) messages representing detected pupils and associated gaze direction.

The node will optionally publish annotated images showing the detected pupils if the parameter `publish_annotated_frame` is set `True`.

## Install
An example to install this package and dependencies, and run live using a webcam:
```

```