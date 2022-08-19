#! /bin/bash

echo $@

gnome-terminal --tab -- bash -c ". coor_ws/install/setup.bash; . guidance_ws/install/setup.bash; ros2 launch FEI_ws/fly_eagle_integrated_spawn.launch.py robot_name:=$@"
gnome-terminal --tab -- bash -c ". coor_ws/install/setup.bash; . guidance_ws/install/setup.bash; . vision_ws/install/setup.bash; ros2 launch FEI_ws/fly_eagle_integrated_vision.launch.py robot_name:=$@"
gnome-terminal --tab -- bash -c ". coor_ws/install/setup.bash; . guidance_ws/install/setup.bash; ros2 launch FEI_ws/fly_eagle_integrated_control.launch.py robot_name:=$@"


if [ $@ == 'tuav_1' -o $@ == 'tuav_2' -o $@ == 'tuav_3' ]; then
    gnome-terminal --tab -- bash -c "cd unet_ros2; python3 unet_ros_'$@'.py; exec bash"
fi