#!/bin/bash

pump_alarm_value=$(mosquitto_sub -h localhost -u my_user -P my_password -t "Radish/Alarm/Plant" -C 1)
plant_alarm_value=$(mosquitto_sub -h localhost -u my_user -P my_password -t "Radish/Alarm/Pump" -C 1)

if [ $pump_alarm_value == 1 ] || [ $plant_alarm_value == 0 ]
then
	echo "1"
else
	echo "0"
fi
