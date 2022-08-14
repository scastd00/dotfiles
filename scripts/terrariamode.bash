#!/bin/bash

# Script to switch to Terraria mouse bindings for quick hook and heal.

FILE="/home/samuel/.customEnv/terraria_mode_enabled"

function display_info() {
  notify-send -i applications-games "Terraria" "$1"
}

if [ "$(cat $FILE)" == "0" ]; then
  sudo rivalcfg --buttons="buttons(button1=button1; button2=button2; button3=button3; button4=H; button5=Y; button6=dpi; scrollup=scrollup; scrolldown=scrolldown; layout=qwerty)"
  echo 1 > $FILE
  display_info "Terraria mode enabled"
else
  sudo rivalcfg --buttons="buttons(button1=button1; button2=button2; button3=button3; button4=button4; button5=button5; button6=dpi; scrollup=scrollup; scrolldown=scrolldown; layout=qwerty)"
  echo 0 > $FILE
  display_info "Terraria mode disabled"
fi

