#!/bin/bash

# Read the file name from the command-line arguments
file="$1"

# Use awk to extract the last column and join the values with commas
result=$(awk '{print $NF}' "$file" | paste -sd ",")

# Print the result
echo "$result"
