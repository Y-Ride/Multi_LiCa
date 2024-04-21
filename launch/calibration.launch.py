import os

from ament_index_python.packages import get_package_share_directory
from launch_ros.actions import Node

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument
from launch.substitutions import Command, LaunchConfiguration


def generate_launch_description():
    pkg_share = get_package_share_directory("multi_lidar_calibrator")
    parameter_file = os.path.join(pkg_share, "config", "demo.yaml")
    output = os.path.join(pkg_share, "output")
    output_dir_arg = DeclareLaunchArgument(
        "out_dir", default_value=output, description="Path to the output directory."
    )

    params_declare = DeclareLaunchArgument(
        "params",
        default_value=parameter_file,
        description="Path to the ROS2 parameters file to use.",
    )

    print("config_file_path : {}".format(parameter_file))

    return LaunchDescription(
        [
            params_declare,
            output_dir_arg,
            Node(
                package="multi_lidar_calibrator",
                executable="multi_lidar_calibrator",
                name="multi_lidar_calibration_node",
                parameters=[parameter_file],
                output="screen",
            ),
        ]
    )
