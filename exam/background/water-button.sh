#!/bin/bash

button_state=0
mkfifo button_state_pipe

eval_button_state() {
	if [ button_state == 1 ]
	then
		bash ~/scripts/exam/helpers/water.sh	
	fi
}

on_button_message() {
	while read message; do
        	echo $message > button_state_pipe
    	done
}

# Function to cleanup background processes when the script is terminated
cleanup() {
    kill $(jobs -p) 2>/dev/null
    rm button_state_pipe
    exit 0
}

# Set the trap to call the cleanup function when the script receives the EXIT, INT, or TERM signal
trap cleanup EXIT INT TERM

mosquitto_sub -h localhost -u my_user -P my_password -t "Remote/Button" | on_button_message &

# Run the loop indefinitely to publish the states
while true; do
    # Read values from named pipes (FIFOs)
    read button_state < button_state_pipe

    eval_button_state
    sleep 2 # The button must only be pressed every 2 seconds
done

