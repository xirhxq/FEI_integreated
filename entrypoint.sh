#! /bin/bash

echo $@

. ~/coor_ws/install/setup.bash
. ~/guidance_ws/install/setup.bash
. ~/vision_ws/install/setup.bash

# gnome-terminal --tab -- bash -c ". coor_ws/install/setup.bash; . guidance_ws/install/setup.bash; ros2 launch FEI_ws/fly_eagle_integrated_spawn.launch.py robot_name:=$@"



# gnome-terminal --tab -- bash -c ". ~/coor_ws/install/setup.bash; \
#                                  . ~/guidance_ws/install/setup.bash; \
#                                  . ~/vision_ws/install/setup.bash; \
#                                  ros2 launch ~/FEI_integrated/fly_eagle_integrated_vision.launch.py robot_name:=$@;
#                                  exec bash"
# gnome-terminal --tab -- bash -c ". ~/coor_ws/install/setup.bash; \
#                                  . ~/guidance_ws/install/setup.bash; \
#                                  . ~/localization_ros2_ws/install/setup.bash; \
#                                  ros2 launch ~/FEI_integrated/fly_eagle_integrated_control.launch.py robot_name:=$@;
#                                  exec bash"
# gnome-terminal --tab -- bash -c ". ~/localization_ros2_ws/install/setup.bash; \
#                                  ros2 launch ~/FEI_integrated/fly_eagle_integrated_locate.launch.py robot_name:=$@;
#                                  exec bash"


if [[ $@ == 'tuav_1' ]] || [[ $@ == 'tuav_2' ]] || [[ $@ == 'tuav_3' ]]; then
    cd ~/unet_ros2
    python3 unet_ros_$@.py &
    echo -e "\033[31msuccessfully run unet_ros_$@.py\033[0m"
    sleep 1
    # gnome-terminal --tab -- bash -c "cd ~/unet_ros2; python3 unet_ros_'$@'.py; exec bash"
fi



# roslaunch ros_ign_pose_bridge gt.launch
# rosparam load ~/localization_ros2_ws/src/ros1_bridge/config/bridge_buav_paramter.yaml
# ros2 run ros1_bridge parameter_bridge

# rviz -d ~/localization_ros1_ws/src/r3live/config/rviz/multi_agents.rviz
# roscore
# rosparam set use_sim_time true

for i in 1 2 3; do
    if [[ $@ == "buav_$i" ]]; then
        echo $@

        . /opt/ros/noetic/setup.bash
        . ~/localization_ros1_ws/devel/setup.bash

        # if [[ $@ == "buav_1" ]]; then
        roscore &
        echo -e "\033[31msuccessfully run roscore\033[0m"
        # fi

        sleep 10

        rosparam set use_sim_time true
        rosparam load ~/localization_ros2_ws/src/ros1_bridge/config/bridge_buav_paramter.yaml
        echo -e "\033[31msuccessfully set params\033[0m"
        sleep 10

        . ~/localization_ros2_ws/install/setup.bash
 
        ros2 run ros1_bridge parameter_bridge &
        echo -e "\033[31msuccessfully run parameter_bridge\033[0m"
        sleep 10

        ros2 launch ros1_bridge "$@".launch.py &
        echo -e "\033[31msuccessfully launch ros1_bridge\033[0m"
        sleep 10

        ros2 launch base "$@"_takeoff.launch.py &
        echo -e "\033[31msuccessfully launch ${@}_takeoff.launch.py\033[0m"
        sleep 10

        ros2 launch base_ros1_ros2 buav"$i"_tx.launch.py &
        echo -e "\033[31msuccessfully launch buav${i}_tx.launch.py\033[0m"
        sleep 5
        
        # if [[ $@ == "buav_2" ]]; then
        #     sleep 10
        # fi
        # if [[ $@ == "buav_3" ]]; then
        #     sleep 20
        # fi


        roslaunch r3live  multi_agent"$i".launch
        echo -e "\033[31msuccessfully run multi_agent${i}.launch\033[0m"
        sleep 30


        # ros2 launch base_ros1_ros2 buav${i}_tx.launch.py &
        # echo "successfully run buav${i}_tx.launch.py"
        # sleep 10
        # . ~/localization_ros1_ws/devel/setup.bash
        # . opt/ros/noetic/setup.bash
        # roscore &
        # echo "successfully run roscore"
        # sleep 10
        # roslaunch r3live multi_agent${i}.launch &
        # echo "successfully run multi_agent${i}.launch"
        # sleep 10
        # roslaunch ~/localization_ros1_ws/src/Integration/bridge_buav${i}_to_ros1.launch &
        # echo "successfully run bridge_buav${i}_to_ros1.launch"
        # sleep 10
        # gnome-terminal --tab --title="buav_$i" -e  'bash -c "sleep 5; \
        #             source /opt/ros/noetic/setup.bash; \
        #             source ~/localization_ros1_ws/devel/setup.bash; \
        #             roslaunch ~/localization_ros1_ws/src/Integration/bridge_buav'$i'_to_ros1.launch; \
        #             exec bash"'
        # gnome-terminal --tab --title="base_${i}_loc" -e  'bash -c "sleep 50; \
        #     source /opt/ros/noetic/setup.bash; \
        #     source ~/localization_ros1_ws/devel/setup.bash; \
        #     roslaunch r3live  multi_agent'$i'.launch; \
        #     exec bash"' 
        # gnome-terminal --tab --title="buav_${i}_tx" -e  'bash -c "sleep 7; \
        #     . ~/localization_ros2_ws/install/setup.bash; \
        #     ros2 launch base_ros1_ros2 buav'$i'_tx.launch.py; \
        #     exec bash"'
    fi
done


ros2 launch ~/FEI_integrated/fly_eagle_integrated_vision.launch.py robot_name:=$@ &
echo -e "\033[31msuccessfully run fly_eagle_integrated_vision.launch.py for $@\033[0m"

. ~/localization_ros2_ws/install/setup.bash

sleep 1
ros2 launch ~/FEI_integrated/fly_eagle_integrated_locate.launch.py robot_name:=$@ &
echo -e "\033[31msuccessfully run fly_eagle_integrated_locate.launch.py for $@\033[0m"
sleep 1
ros2 launch ~/FEI_integrated/fly_eagle_integrated_control.launch.py robot_name:=$@
echo -e "\033[31msuccessfully run fly_eagle_integrated_control.launch.py for $@\033[0m"