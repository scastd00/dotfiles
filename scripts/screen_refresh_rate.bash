#!/bin/bash

# Take the list of monitors and get only the name of the monitors.
display_list=($(xrandr --listmonitors | awk '{print $4}' | grep '-'))
force=

# Command line parameter "--force"
if [ -z "$1" ] && [ "$1" != "--force" ]; then # Empty
  force=0
elif [ "$1" = "--force" ]; then # force
  force=1
fi

for ((i = ${#display_list[@]} - 1; i >= 0; i--)); do
  rate=
  display="${display_list[i]}"

  case $display in
    # If integrated screen is adjusted first, the apparent refresh rate is 60Hz.
    "HDMI-0") # External monitor first
      if [ "$force" -eq "1" ]; then
        rate=60.00
        xrandr --output "$display" --mode 1920x1080 --rate $rate
      fi

      rate=74.97
      ;;

    "eDP-1-1") # Integrated screen
      if [ "$force" -eq "1" ]; then
        rate=59.97
        xrandr --output "$display" --mode 1920x1080 --rate $rate
      fi

      rate=119.94
      ;;

    *)
      echo "Invalid monitor"
      exit 1
      ;;
  esac

  xrandr --output "$display" --mode 1920x1080 --rate $rate
done
