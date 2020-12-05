#! /bin/bash

compton --backend glx --paint-on-overlay --vsync opengl-swc &
nitrogen --restore &

# lauch notification daemon
/usr/bin/dunst > /dev/null 2>&1 &

setxkbmap -model pc104 -layout it -variant ,qwerty -option grp:alt_shift_toggle

xset +fp $HOME/.local/share/fonts &
xset fp rehash &

# date function
dte(){
    dte="$(date "+%a, %d/%m/%y %H:%M")"
    echo -e "$dte"
}


# wifi function
wfi(){
    wifi=`nmcli dev wifi list | awk '/\*/{if (NR!=1) {print $8}}'`

    # check if $wifi is empty

    if [[ $wifi -gt 74 ]];then      # high signal
        echo -e "\ue0f0"
    elif [[ $wifi -gt 29 ]];then    # mid signal
        echo -e "\ue0ef"
    else
        echo -e "\ue0ee"            # low signal
    fi
}

while true; do
    xsetroot -name "  $(wfi)   $(dte)   "
    sleep 1s
done
