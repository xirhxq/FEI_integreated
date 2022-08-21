#! /bin/bash
# gnome-terminal --tab -- bash -c "ros2 launch mbzirc_ros competition_local.launch.py ign_args:=\" -v 4 -r coast.sdf\" ;exec bash" 
gnome-terminal --tab -- bash -c "ros2 launch mbzirc_ign competition.launch.py world:=coast config_file:=config_team.yaml; exec bash"
sleep 30
# . /opt/ros/noetic/setup.bash
# . ~/localization_ros1_ws/devel/setup.bash
# roscore &
# echo -e "\033[31msuccessfully run roscore\033[0m"
# sleep 10

# gnome-terminal --tab  -e  'bash -c "sleep 1; \
#             source /opt/ros/noetic/setup.bash; \
#             source ~/localization_ros1_ws/devel/setup.bash; \
#             roscore; \
#             exec bash"' 

# gnome-terminal --tab --title="clock" -e  'bash -c "sleep 3; \
#             source /opt/ros/noetic/setup.bash; \
#             source ~/localization_ros1_ws/devel/setup.bash; \
#             rosparam set use_sim_time true; \
#             rosrun ros_ign_bridge parameter_bridge /clock@rosgraph_msgs/Clock[ignition.msgs.Clock; \
#             exec bash"' 

# # msg ros1 <-> ros2
# gnome-terminal --tab  --title="gt" -e  'bash -c "sleep 7; \
#             source /opt/ros/noetic/setup.bash; \
#             source ~/localization_ros1_ws/devel/setup.bash; \
#             roslaunch ros_ign_pose_bridge gt.launch; \
#             exec bash"' 

# gnome-terminal --tab --title="1to2" -e  'bash -c "sleep 7; \
#             source /opt/ros/noetic/setup.bash; \
#             source ~/localization_ros1_ws/devel/setup.bash; \
#             rosparam load ~/localization_ros2_ws/src/Integrating/bridge1_to_2.yaml; \
#             . ~/localization_ros2_ws/install/setup.bash; \
#             ros2 run ros1_bridge parameter_bridge; \
#             exec bash"' 

# gnome-terminal --tab --title="rviz" -e  'bash -c "sleep 60; \
#             source /opt/ros/noetic/setup.bash; \
#             source ~/localization_ros1_ws/devel/setup.bash; \
#             rviz -d ~/localization_ros1_ws/src/r3live/config/rviz/multi_agents.rviz; \
#             exec bash"'

for i in 1 2 3; do
    echo $i
    str_i="buav_${i}"
    echo $str_i
    gnome-terminal --tab -- bash -c "./entrypoint.sh ${str_i}; exec bash" 
done

# gnome-terminal --tab -- bash -c "ros2 run ros_ign_bridge my_bridge; exec bash"

for i in 1 14; do
    echo $i
    str_i="suav_${i}"
    echo $str_i
    gnome-terminal --tab -- bash -c "./entrypoint.sh ${str_i}; exec bash" 
done


for i in 1; do
    echo $i
    str_i="tuav_${i}"
    echo $str_i
    gnome-terminal --tab -- bash -c "./entrypoint.sh ${str_i}; exec bash" 
done