# Embedded Linux - Exam

Embedded Linux Exam files by group 17

## The “Sensor” system folders
- pico-sensor: Contains code for the pico used as a water pump and sensor collector for the system.

## The “Server” system folders
- background: Contains shell scripts which runs in the background to ensure collection of sensor readings, logging, and reacting to system events and states.
- cron: Contains shell scripts which runs as cron jobs to ensure that the plant is watered every 12 hours or if dry.
- health-scripts: Contains shell scripts which can be called to collect different indicators of system health.
- helpers: Contains shell scripts which are used as helper functions by the background scripts and cron jobs to perform their respective functions.
- html: Contains the PHP pages hosted on the Apache2 web server.
- logs: Contains the collected log files.

## The “Remote” system folders
- esp8266-remote: Contains code for the esp8266 used as a remote for the system.
