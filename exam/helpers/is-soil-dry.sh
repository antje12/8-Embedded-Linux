#!/bin/bash

soil_moisture=$(mosquitto_sub -h localhost -u my_user -P my_password -t "Radish/Sensor/Moisture" -C 1)

if [ $soil_moisture -lt 75 ]
then
        echo "1"
else
        echo "0"
fi
