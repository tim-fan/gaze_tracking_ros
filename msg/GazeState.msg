#MSG to record state of user gaze tracking at a point in time
Header header
bool is_left #True if the user is looking to the left.
bool is_right #True if the user is looking to the right.
bool is_center #True if the user is looking at the center.
bool is_blinking #True if the user's eyes are closed.
geometry_msgs/Point pupil_left_coords
geometry_msgs/Point pupil_right_coords
float32 horizontal_ratio #a number between 0.0 and 1.0 that indicates the horizontal direction of the gaze. The extreme right is 0.0, the center is 0.5 and the extreme left is 1.0.
float32 vertical_ratio #a number between 0.0 and 1.0 that indicates the vertical direction of the gaze. The extreme top is 0.0, the center is 0.5 and the extreme bottom is 1.0.
