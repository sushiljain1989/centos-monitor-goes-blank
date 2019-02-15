#!/bin/bash
#I have two connected monitors and their names are: DP-1-1 and DP-1-2. 
# These names can be get from xrand command: xrandr --listmonitors
# I have MONITOR_ONE as primary display and MONITOR_TWO as secondary display which is placed on the right side of MONITOR_ONE

#This script keeps listening for locked/unlocked event and restart the monitor#2(MONITOR_TWO) on unlock event
#and positions it on the right side of my primary display(MONITOR_ONE)
MONITOR_ONE=DP-1-1 #Primary display
MONITOR_TWO=DP-1-2 #Secondary display, placed to right of MONITOR_ONE
gdbus monitor -y -d org.freedesktop.login1 | while true
do
    read input;
    if [[ $input == *"LockedHint': <false>"* ]]; then
  	echo "It's unlocked! Resetting monitor#2"
	xrandr --output $MONITOR_TWO --off && xrandr --output $MONITOR_TWO --auto --right-of $MONITOR_ONE
    fi
done
