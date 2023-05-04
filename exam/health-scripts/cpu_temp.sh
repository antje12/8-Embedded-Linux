#!/bin/bash

vcgencmd measure_temp | awk -F'[=.]' '{print $2}'
