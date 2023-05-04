#!/bin/bash

data=$(python3 /scripts/lesson4/read_mcp3008.py)
curl -X POST https://api.thingspeak.com/update -d "api_key=WP51DMROO034GJUH&field1=$data"
