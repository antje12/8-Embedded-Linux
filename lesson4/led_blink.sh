#!/bin/bash

cleanup() {
	echo "Cleaning"
	echo "26" > /sys/class/gpio/unexport
}

trap cleanup EXIT

echo "26" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio26/direction


while [ true ]
do
	ping_laptop=$(ping -c 1 -W 2 10.0.0.1)
	ping_internet=$(ping -c 1 -W 2 1.1.1.1)

	if [[ $ping_laptop != *"1 received"* && $ping_internet != *"1 received"* ]]; then
		echo "1" > /sys/class/gpio/gpio26/value
		echo "0" > /sys/class/gpio/gpio26/value
	elif [[ $ping_laptop == *"1 received"* && $ping_internet != *"1 received"* ]]; then
		echo "1" > /sys/class/gpio/gpio26/value
		echo "0" > /sys/class/gpio/gpio26/value
		sleep 0.5	
		echo "1" > /sys/class/gpio/gpio26/value
		echo "0" > /sys/class/gpio/gpio26/value
	elif [[ $ping_laptop == *"1 received"* && $ping_internet == *"1 received"* ]]; then
		echo "1" > /sys/class/gpio/gpio26/value
		echo "0" > /sys/class/gpio/gpio26/value
		sleep 0.5	
		echo "1" > /sys/class/gpio/gpio26/value
		echo "0" > /sys/class/gpio/gpio26/value
		sleep 0.5	
		echo "1" > /sys/class/gpio/gpio26/value
		echo "0" > /sys/class/gpio/gpio26/value
	fi

	sleep 10
done


