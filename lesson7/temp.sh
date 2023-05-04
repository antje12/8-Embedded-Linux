#!/bin/bash

BROKER="localhost" # Replace with your MQTT broker address
PORT="1883"                  # Replace with your MQTT broker port, if different
TOPIC="temp"      # Replace with your desired MQTT topic

while true; do
    # Read the CPU temperature in millidegrees Celsius
    cpu_temp_milli=$(cat /sys/class/thermal/thermal_zone0/temp)

    # Convert millidegrees Celsius to degrees Celsius
    cpu_temp_c=$(echo "scale=1; $cpu_temp_milli / 1000" | bc)

    # Print the CPU temperature in degrees Celsius
    echo "CPU Temp: $cpu_temp_c °C"

    # Publish the CPU temperature to the MQTT broker
    mosquitto_pub -h $BROKER -p $PORT -u my_user -P my_password -t $TOPIC -m $cpu_temp_c

    # Wait for 15 seconds
    sleep 15
done
