# How to compile integrated code

## localization_ros1_ws (bUAV)

```bash
. /opt/ros/noetic/setup.bash
cd localization_ros1_ws
catkin_make
```

## localization_ros2_ws (bUAV)

```bash
cd localization_ros2_ws
colcon build
```

## coor_ws (sUAV)

```bash
cd coor_ws
colcon build
```

## guidance_ws (tUAV)

```bash
cd guidance_ws
colcon build
```

## vision_ws (everyUAV)

```bash
cd vision_ws/src/mbzirc
./build.sh # Need password
```
