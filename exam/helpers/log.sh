#!/bin/bash

# Check if the required arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <filename> <value>"
  exit 1
fi

filename=$1
value=$2

# Set the log directory one level up
log_directory="/home/pi/scripts/exam/logs"

# Create the log directory if it doesn't exist
mkdir -p "$log_directory"

# Update the filename with the log directory path
filename="${log_directory}/${filename}.txt"

# Check if the value is numeric
if ! [[ $value =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
  echo "Error: Value must be numeric."
  exit 1
fi

# Create the file with headers if it does not exist
if [ ! -f "$filename" ]; then
  echo "Timestamp,Value" > "$filename"
fi

# Get the current timestamp in the format "Hours:minutes:seconds"
timestamp=$(date +"%H:%M:%S")

# Write the timestamp and value to the CSV file
echo "$timestamp,$value" >> "$filename"
