#!/bin/bash

sudo bash -c 'date +%s > /home/pi/scripts/exam/helpers/timestamp.txt'

/home/pi/scripts/exam/helpers/log.sh pump_activations 1
echo "p" > /dev/ttyACM0
