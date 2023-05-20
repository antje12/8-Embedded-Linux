#!/bin/bash

is_soil_dry=$(bash /home/pi/scripts/exam/helpers/is-soil-dry.sh)

if [ "$is_soil_dry" == "1" ]
then
	/home/pi/scripts/exam/helpers/attempt-water.sh 1 h
fi
