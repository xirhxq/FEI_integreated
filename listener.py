#!/usr/bin/env python

import rclpy
from rclpy.node import Node
from sensor_msgs.msg import Imu, FluidPressure
from time import sleep
from functools import partial

list = range(8, 15, 1)

class Listener(Node):
    def __init__(self):
        super().__init__('listener')
        self.suav_imu_existence = [False] * 14
        self.suav_baro_existence = [False] * 14
        print(self.suav_imu_existence)
        for i in range(1, 15):
            self.create_subscription(
                Imu,
                '/suav_' + str(i) + '/imu/data',
                # self.get_imu,
                partial(self.tmp_callback, index=i - 1, type='imu'),
                10
            )
            print('set imu callback for suav_' + str(i))
            self.create_subscription(
                FluidPressure,
                '/suav_' + str(i) + '/air_pressure',
                # self.get_imu,
                partial(self.tmp_callback, index=i - 1, type='baro'),
                10
            )
            print('set baro callback for suav_' + str(i))

    
    def tmp_callback(self, msg, index, type):
        if type == 'imu':
            if self.suav_imu_existence[index]:
                return
            self.suav_imu_existence[index] = True
            print('get suav_' + str(index + 1) + '\'s imu data: {:.2f}, {:.2f}, {:.2f}, {:.2f}'.format(
                msg.orientation.x, msg.orientation.y, msg.orientation.z, msg.orientation.w
            ))
            print('imu absence:', end='')
            for i in range(0, 14):
                if self.suav_imu_existence[i] == False:
                    if i + 1 in list:
                        print(i + 1, end=',')
            print(' ')
            imu_exist = [self.suav_imu_existence[i - 1] for i in list]
            baro_exist = [self.suav_baro_existence[i - 1] for i in list]
            if all(imu_exist) and all(baro_exist):
                print('get all imu data and baro data')
                assert 0
        elif type == 'baro':
            if self.suav_baro_existence[index]:
                return
            self.suav_baro_existence[index] = True
            print('get suav_' + str(index + 1) + '\'s baro data: {:.2f}'.format(
                msg.fluid_pressure
            ))
            print('baro absence:', end='')
            for i in range(0, 14):
                if self.suav_baro_existence[i] == False:
                    if i + 1 in list:
                        print(i + 1, end=',')
            print(' ')
            imu_exist = [self.suav_imu_existence[i - 1] for i in list]
            baro_exist = [self.suav_baro_existence[i - 1] for i in list]
            if all(imu_exist) and all(baro_exist):
                print('get all imu data and baro data')
                assert 0


def main(args=None):
    assert 1
    rclpy.init(args=args)
    listener = Listener()
    rclpy.spin(listener)
    
    rclpy.shutdown()


if __name__ == '__main__':
    main()