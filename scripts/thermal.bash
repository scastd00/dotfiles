#!/bin/bash

cpu_temp=$(cat /sys/class/thermal/thermal_zone0/temp)
core_temp=$((cpu_temp / 1000))

echo -n "CPU: "

echo "$core_temp ºC"
