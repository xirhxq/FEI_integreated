from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, OpaqueFunction, IncludeLaunchDescription
from launch.substitutions import LaunchConfiguration, TextSubstitution, PathJoinSubstitution
from launch_ros.actions import Node
from launch_ros.descriptions import ParameterValue
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch_ros.substitutions import FindPackageShare

from ament_index_python.packages import get_package_share_directory


def launch(context, *arge, **kwargs):
    #pkg_share_dir = get_package_share_directory('vessel_det')
    #yaml_path = pkg_share_dir + '/configs/config.yaml'
    # print(context)
    
    robot_name = LaunchConfiguration('robot_name').perform(context)
    ld = []
    
    if robot_name[:4] != 'buav':
        ld.append(
            IncludeLaunchDescription(
                PythonLaunchDescriptionSource([
                    PathJoinSubstitution([
                        FindPackageShare('range_localization'),
                        'launch',
                        robot_name + '_node.launch.py'
                    ])
                ])
            )
        )
    
        
    return ld
    
def generate_launch_description():
    return LaunchDescription([
        DeclareLaunchArgument(
            'robot_name',
            default_value='',
            description='Robot name to launch'
        ),
        OpaqueFunction(function=launch)
    ])
