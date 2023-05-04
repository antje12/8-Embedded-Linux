#!/bin/bash

cleanup() {
	echo "16" > /sys/class/gpio/unexport
}

trap cleanup EXIT

echo "16" > /sys/class/gpio/export
echo "in" > /sys/class/gpio/gpio16/direction

cat /sys/class/gpio/gpio16/value




