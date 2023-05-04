#!/bin/bash

# Check if the threshold is provided as an argument
if [ $# -ne 2 ]; then
  exit 1
fi

is_alarm_active=$(bash /home/pi/scripts/exam/helpers/is-alarm-active.sh)

if [ $is_alarm_active == 1 ]
then
  exit 2
fi

threshold_value=$1
threshold_unit=$2

# Convert the threshold to seconds
case $threshold_unit in
  s) threshold_seconds=$threshold_value ;;
  m) threshold_seconds=$((threshold_value * 60)) ;;
  h) threshold_seconds=$((threshold_value * 3600)) ;;
  *)
    exit 1
    ;;
esac

# Read the timestamp from the file (if it exists)
if [ -f timestamp.txt ]; then
  timestamp=$(cat timestamp.txt)
else
  timestamp=0
fi

# Get the current Unix timestamp
current_timestamp=$(date +%s)

# Calculate the time difference in seconds
time_diff_seconds=$((current_timestamp - timestamp))

# Check if the time difference is greater than or equal to the threshold
if [ $time_diff_seconds -ge $threshold_seconds ]; then
  echo "Threshold value has passed. Executing water.sh."
  bash ./water.sh
else
  remaining_seconds=$((threshold_seconds - time_diff_seconds))
  echo "Threshold value has not passed. $remaining_seconds seconds remaining."
fi

