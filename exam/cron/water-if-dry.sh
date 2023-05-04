#!/bin/bash

is_soil_dry=$(is_soil_dry.sh)

if [ is_soil_dry == 1 ]
then
	attempt_water.sh 1 h
fi
