#!/bin/bash

while [ true ]
do
	sensor_readings=$(cat /dev/ttyACM0 | head -n 1)

	plant_water_alarm=$(echo "$sensor_readings" | cut -d ',' -f 1)
	pump_water_alarm=$(echo "$sensor_readings" | cut -d ',' -f 2)
	soil_moisture=$(echo "$sensor_readings" | cut -d ',' -f 3)
	light=$(echo "$sensor_readings" | cut -d ',' -f 4)

	mosquitto_pub -h localhost -p 1883 -u my_user -P my_password -t "Radish/Alarm/Plant" -m $plant_water_alarm -r
	mosquitto_pub -h localhost -p 1883 -u my_user -P my_password -t "Radish/Alarm/Pump" -m $pump_water_alarm -r
	mosquitto_pub -h localhost -p 1883 -u my_user -P my_password -t "Radish/Sensor/Moisture" -m $soil_moisture -r
	mosquitto_pub -h localhost -p 1883 -u my_user -P my_password -t "Radish/Sensor/Light" -m $light -r

	/home/pi/scripts/exam/helpers/log.sh soil_moisture $((soil_moisture))
	/home/pi/scripts/exam/helpers/log.sh plant_water_alarm $((plant_water_alarm))
	/home/pi/scripts/exam/helpers/log.sh pump_water_alarm $((pump_water_alarm))
	/home/pi/scripts/exam/helpers/log.sh light $((light))

	sleep 1s
done
