#!/bin/bash

ifconfig wlan0 | awk '/RX packets/ {print $5}' | cut -d: -f2
