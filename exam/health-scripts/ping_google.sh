#!/bin/bash

ping_result=$(ping -c 1 google.com 2>&1)
if [[ $? -eq 0 ]]; then
  latency=$(echo "$ping_result" | awk -F 'time=' '{print $2}' | awk -F ' ms' '{print $1}')
else
  latency=-1
fi

echo $latency

