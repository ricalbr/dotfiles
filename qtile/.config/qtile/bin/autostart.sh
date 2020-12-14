#! /bin/bash

nitrogen --restore &
# compton --backend glx --paint-on-overlay --vsync opengl-swc &
picom &
nm-applet --sm-disable &
/usr/bin/redshift &
/usr/bin/dunst > /dev/null 2>&1 &
