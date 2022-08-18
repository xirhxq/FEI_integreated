#! /bin/bash

for i in 1 2 3; do
    echo $i
    str_i="suav_${i}"
    echo $str_i
    gnome-terminal --tab -- bash -c ". coor_ws/install/setup.bash; ros2 launch FEI_ws/fly_eagle_integrated_spawn.launch.py robot_name:=${str_i}"
    gnome-terminal --tab -- bash -c ". coor_ws/install/setup.bash; ros2 launch FEI_ws/fly_eagle_integrated_vision.launch.py robot_name:=${str_i}"
    gnome-terminal --tab -- bash -c ". coor_ws/install/setup.bash; ros2 launch FEI_ws/fly_eagle_integrated_control.launch.py robot_name:=${str_i}"
    # gnome-terminal --tab -- bash -c "./FEI_ws/entrypoint.sh suav_${i}; exec bash" 
done