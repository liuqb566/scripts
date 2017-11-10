#!/bin/bash

#add 1920x1080 
cvt 1920 1080 || (exit 0 && echo 'cvt err')
xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync||(exit 0 && echo 'xrandr --newmode err')
xrandr --addmode VGA-1 "1920x1080_60.00" ||(exit 0 && echo '--addmode err')
#sudo xrander --addmode HDMI-1 "1920x1080_60.00"

#打开投影仪
xrandr --output VGA-1 --same-as LVDS-1 --mode "1920x1080_60.00" ||(exit 0 && echo '--output err')
#xrander --output HDMI-1 --same-as LVDS-1 --mode "1920x1080_60.00"
