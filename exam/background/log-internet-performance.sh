#!/bin/bash

while true; do
	ping_latency=$(bash /home/pi/scripts/exam/health-scripts/ping_google.sh)
	packets=$(bash /home/pi/scripts/exam/health-scripts/network_traffic.sh)
 
	/home/pi/scripts/exam/helpers/log.sh ping_latency $ping_latency
	/home/pi/scripts/exam/helpers/log.sh network_packets $packets

	sleep 10
done
