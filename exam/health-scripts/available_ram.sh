#!/bin/bash

free | awk '/^Mem/{print ($4/$2)*100.0}'
