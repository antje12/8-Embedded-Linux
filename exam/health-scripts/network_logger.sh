#!/bin/bash

# Set the path to the file containing the value to log
VALUE_FILE=/var/www/scripts/network_traffic.sh

# Set the path to the log file
LOG_FILE=/var/www/scripts/network_log

# Get the current epoch timestamp
EPOCH_TIMESTAMP=$(date +%s)

# Get the value from the other script
VALUE=$(sh $VALUE_FILE)

# Write the epoch timestamp and value to the log file
echo "$EPOCH_TIMESTAMP,$VALUE" >> $LOG_FILE

