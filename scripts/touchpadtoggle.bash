#!/bin/bash

# Script to activate and deactivate the computer's touchpad

read TPdevice <<< "$( xinput | sed -nre '/TouchPad|Touchpad/s/.*id=([0-9]*).*/\1/p' )"
state=$( xinput list-props "$TPdevice" | grep "Device Enabled" | grep -o "[01]$" )

if [ "$state" -eq '1' ];then
    xinput --disable "$TPdevice"
    notify-send -h int:transient:1 "Touchpad disabled"
else
    xinput --enable "$TPdevice"
    notify-send -h int:transient:1 "Touchpad enabled"
fi

