#!/bin/bash

# Set the path to the log file
LOG_FILE=./cron_script_log

# Get the current epoch timestamp
EPOCH_TIMESTAMP=$(date +%s)

# Get the value from the other script
VALUE=$1

# Write the epoch timestamp and value to the log file
echo "$EPOCH_TIMESTAMP,$VALUE" >> $LOG_FILE

