#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

xhost +local:

docker run -it --rm --privileged \
    --network host \
    --name multi_lidar_calibration_container \
    -e DISPLAY=${DISPLAY} \
    -e ROS_DOMAIN_ID=1 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $SCRIPT_DIR/../config:/ros_ws/src/multi_lidar_calibration/config \
    -v $SCRIPT_DIR/../data:/ros_ws/src/multi_lidar_calibration/data \
    -v $SCRIPT_DIR/../output:/ros_ws/src/multi_lidar_calibration/output \
    -v $SCRIPT_DIR/../launch:/ros_ws/src/multi_lidar_calibration/launch \
    -v $SCRIPT_DIR/../multi_lidar_calibrator:/ros_ws/src/multi_lidar_calibration/multi_lidar_calibrator \
    multi_lidar_calibration:latest \
    /bin/bash

xhost -local:
