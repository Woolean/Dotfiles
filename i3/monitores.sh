#!/bin/sh

sleep 6

xrandr --newmode "1600x900_60.00" 119.00  1600 1696 1864 2128  900 901 904 932  -HSync +Vsync

xrandr --addmode VGA-1 "1600x900_60.00"

# RESOLUTION SETTINGS
# This sets your VGA1 monitor to its best resolution.
xrandr --output HDMI-1 --mode 1920x1080 --rate 60
# This sets your laptop monitor to its best resolution.
xrandr --output VGA-1 --mode "1600x900_60.00"

# MONITOR ORDER
# Put the Laptop right, VGA1 monitor left
# xrandr --output VGA1 --left-of LVDS1
# Put the Laptop left, VGA1 monitor right
xrandr --output HDMI-1 --left-of VGA-1

# PRIMARY MONITOR
# This sets your laptop monitor as your primary monitor.
xrandr --output HDMI-1 --primary
# This sets your VGA monitor as your primary monitor.
# xrandr --output VGA1 --primary
