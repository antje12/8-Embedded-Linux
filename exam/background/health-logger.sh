#!/bin/bash

while true; do
	disk_space=$(bash /home/pi/scripts/exam/health-scripts/available_disk_space.sh)
	ram=$(bash /home/pi/scripts/exam/health-scripts/available_ram.sh)
	load=$(bash /home/pi/scripts/exam/health-scripts/cpu_load.sh)
	temp=$(bash /home/pi/scripts/exam/health-scripts/cpu_temp.sh)

	/home/pi/scripts/exam/helpers/log.sh available_disk_space $((disk_space))
	/home/pi/scripts/exam/helpers/log.sh available_ram $((ram))
	/home/pi/scripts/exam/helpers/log.sh cpu_load $((load))
	/home/pi/scripts/exam/helpers/log.sh cpu_temp $((temp))
	
	sleep 10
done
