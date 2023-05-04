#!/bin/bash

# Function to publish MQTT messages
publish_states() {
	is_alarm_active=$(bash /home/pi/scripts/exam/helpers/is-alarm-active.sh)
	is_soil_dry=$(bash /home/pi/scripts/exam/helpers/is-soil-dry.sh)

	if [ $is_alarm_active == 1 ]
	then
        	mosquitto_pub -h localhost -u my_user -P my_password -t "Remote/Yellow" -m "1";
	else
        	mosquitto_pub -h localhost -u my_user -P my_password -t "Remote/Yellow" -m "0";
	fi

	if [ $is_soil_dry == 1 ]
	then
        	mosquitto_pub -h localhost -u my_user -P my_password -t "Remote/Red" -m "1";
	else
        	mosquitto_pub -h localhost -u my_user -P my_password -t "Remote/Red" -m "0";
	fi

	if [ $is_alarm_active == 0 ] && [ $is_soil_dry == 0 ]
	then
        	mosquitto_pub -h localhost -u my_user -P my_password -t "Remote/Green" -m "1"; 
	else
        	mosquitto_pub -h localhost -u my_user -P my_password -t "Remote/Green" -m "0"; 
	fi
}

# Run the loop indefinitely to publish the states
while true; do
    publish_states
    sleep 1 # Adjust the sleep duration to control how often the states are published
done
