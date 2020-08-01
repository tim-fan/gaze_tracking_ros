#!/usr/bin/env python
import rospy
from sensor_msgs.msg import Image
from gaze_tracking_ros.msg import GazeState
from gaze_tracking import GazeTracking
from cv_bridge import CvBridge, CvBridgeError
import cv2

class GazeExtractor:
    def __init__(self):
        self.cv_bridge = CvBridge()
        self.gaze = GazeTracking()
        self.publish_annotated_frame = rospy.get_param("~publish_annotated_frame", True)
        if self.publish_annotated_frame:
            self.annotated_frame_publisher = rospy.Publisher('image_annotated_raw', Image, queue_size=10)
        self.gaze_publisher = rospy.Publisher('gaze_state', GazeState, queue_size=10)
    
    def extract_from_image(self, img_msg):
        
        #convert image to opencv type
        try:
            cv_image = self.cv_bridge.imgmsg_to_cv2(img_msg, "bgr8")
        except CvBridgeError as e:
            print(e)
            return

        #run gaze detection
        self.gaze.refresh(cv_image)

        #if desired, publish annotated frame
        if self.publish_annotated_frame:
            annotated_image_msg = self.cv_bridge.cv2_to_imgmsg(
                self.gaze.annotated_frame(), "bgr8"
            )
            self.annotated_frame_publisher.publish(annotated_image_msg)
        
        #if no pupils detected, stop here
        if not self.gaze.pupils_located:
            return
        
        #pack gaze tracking result into a GazeState message and publish
        result_msg = GazeState()
        result_msg.header = img_msg.header
        result_msg.is_left = self.gaze.is_left()
        result_msg.is_right = self.gaze.is_right()
        result_msg.is_center = self.gaze.is_center()
        result_msg.is_blinking = self.gaze.is_blinking()
        result_msg.pupil_left_coords.x = self.gaze.pupil_left_coords()[0]
        result_msg.pupil_left_coords.y = self.gaze.pupil_left_coords()[1]
        result_msg.pupil_right_coords.x = self.gaze.pupil_right_coords()[0]
        result_msg.pupil_right_coords.y = self.gaze.pupil_right_coords()[1]
        result_msg.horizontal_ratio = self.gaze.horizontal_ratio()
        result_msg.vertical_ratio = self.gaze.vertical_ratio()

        self.gaze_publisher.publish(result_msg)
    

def pupil_tracker():
    rospy.init_node('pupil_tracker')
    gaze_extractor = GazeExtractor()
    rospy.Subscriber("image_raw", Image, gaze_extractor.extract_from_image)
    rospy.spin()

if __name__ == '__main__':
    pupil_tracker()