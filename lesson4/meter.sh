#!/bin/bash

while [ true ]
do
	light_data=$(python3 /scripts/lesson4/read_mcp3008.py)
	angle=$(($(($light_data))*180/1000))

	$(python3 /scripts/lesson4/servo_control.py $angle)
	sleep 2
done
