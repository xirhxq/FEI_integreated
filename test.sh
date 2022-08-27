#! /bin/bash

if [[ $@ == 'gt' ]]; then
gnome-terminal --tab -- bash -c "ros2 launch mbzirc_ign competition.launch.py world:=coast config_file:=config_team_gt.yaml; exec bash"
else
gnome-terminal --tab -- bash -c "ros2 launch mbzirc_ign competition.launch.py world:=coast config_file:=config_team.yaml; exec bash"
fi

/bin/python3 /home/ps/FEI_integrated/listener.py

sleep 5

for i in 1 2 3; do
    echo $i
    str_i="buav_${i}"
    echo $str_i
    if [[ $@ == 'gt' ]]; then
    gnome-terminal --tab -- bash -c "./entrypoint_gt.sh ${str_i}; exec bash"
    else
    gnome-terminal --tab -- bash -c "./entrypoint.sh ${str_i}; exec bash" 
    fi
done

for i in 8 9 10 11 12 13 14; do
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

# echo "usv"
# str_i="usv"
# gnome-terminal --tab -- bash -c "./entrypoint.sh usv; exec bash"

if [[ $@ == 'gt' ]]; then
ros2 run search commander
fi