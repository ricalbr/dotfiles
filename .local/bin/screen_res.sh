#! /bin/bash

# 1920x998 @ 59.95 Hz (GTF) hsync: 61.93 kHz; pclk: 158.54 MHz
# Modeline "1920x998_59.95"  158.54  1920 2032 2240 2560  998 999 1002 1033  -HSync +Vsync

xrandr --newmode "1920x998_59.95"  158.54  1920 2032 2240 2560  998 999 1002 1033  -HSync +Vsync
xrandr --addmode Virtual-1 "1920x998_59.95"
xrandr --output Virtual-1 --primary --mode "1920x998_59.95" --pos 0x0 --rotate normal
