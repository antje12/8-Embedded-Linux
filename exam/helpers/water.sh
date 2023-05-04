#!/bin/bash

date +%s > timestamp.txt

log.sh pump_activations 1
echo "p" > /dev/ttyACM0
