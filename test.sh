#! /bin/bash
gnome-terminal --tab -- bash -c "ros2 launch mbzirc_ros competition_local.launch.py ign_args:=\" -v 4 -r coast.sdf\" ;exec bash" 
# gnome-terminal --tab -- bash -c "ros2 run ros_ign_bridge my_bridge; exec bash"
# for i in 1 2 3 4 5; do
#     echo $i
#     str_i="suav_${i}"
#     echo $str_i
#     gnome-terminal --tab -- bash -c "./FEI_ws/entrypoint.sh ${str_i}; exec bash" 
# done

for i in 1 2 3; do
    echo $i
    str_i="tuav_${i}"
    echo $str_i
    gnome-terminal --tab -- bash -c "./FEI_ws/entrypoint.sh ${str_i}; exec bash" 
done