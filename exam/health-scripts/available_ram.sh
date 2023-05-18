#!/bin/bash

free | awk '/^Mem/ {printf("%.0f\n", ($4/$2)*100)}'
