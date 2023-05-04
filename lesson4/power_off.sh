#!/bin/bash

count=0

while [ true ] 
do

	switch_status=$(/scripts/lesson4/read_switch.sh)
	if [ "$switch_status" = "1" ]
	then
		echo "Connected"
		((count=count+1))
	else
		echo "Disconnected"
		((count=0))
	fi

	if [ $count -gt 2 ]
	then
		poweroff
	fi

	sleep 1
done


