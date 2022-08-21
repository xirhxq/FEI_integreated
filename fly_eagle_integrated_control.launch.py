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
    
    if robot_name[:4] == 'suav':
        id_str = robot_name[5:]
        id_num = int(id_str)
        print(id_str, id_num)	
        ld.append(
            Node(
                package='search',
                executable='sUAV',
                name='sssss' + id_str,
                arguments=[id_str],
                output='screen'
            )
        )
        
    elif robot_name[:4] == 'tuav':
        id_str = robot_name[5:]
        id_num = int(id_str)
        print(id_str, id_num)
        if id_num == 1:	
          ld.append(
              Node(
                  package='landing',
                  executable='landing',
                  name='t' + id_str,
                  arguments=[id_str],
                  output='screen'
              )
          )	
        elif id_num == 2 or id_num == 3:	
          ld.append(
              Node(
                  package='landing',
                  executable='manipulation',
                  name='t' + id_str,
                  arguments=[id_str],
                  output='screen'
              )
          )	
    # elif robot_name[:4] == 'buav':
    #     id_str = robot_name[5:]
    #     id_num = int(id_str)
    #     print(id_str, id_num)

    #     ld.append(
    #         IncludeLaunchDescription(
    #             PythonLaunchDescriptionSource([
    #                 PathJoinSubstitution([
    #                     FindPackageShare('base'),
    #                     'launch',
    #                     'buav_' + id_str + '_takeoff.launch.py'
    #                 ])
    #             ])
    #         )
    #     )
    
        
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
