#!/bin/bash

# Make API call and extract CO2 data as comma-separated list
co2_list=$(curl -s https://kjen.dk/courses/emli/co2/ | jq -r '.[] | .co2' | paste -sd,)
echo $co2_list
