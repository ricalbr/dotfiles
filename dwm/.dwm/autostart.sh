#! /bin/bash

compton --backend glx --paint-on-overlay --vsync opengl-swc &
nitrogen --restore &

# lauch notification daemon
/usr/bin/dunst > /dev/null 2>&1 &

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

    if [[ -z $wifi ]]; then
        echo -e "\ue21f"
    elif [[ $wifi -gt 74 ]];then      # high signal
        echo -e "\ue220"
    elif [[ $wifi -gt 29 ]];then    # mid signal
        echo -e "\ue221"
    else
        echo -e "\ue222"            # low signal
    fi
}

# keyboard layout
kyb(){
    keyb=`setxkbmap -v | awk -F "+" '/symbols/ {print $2}'`
    echo -e "$keyb"
}

while true; do
    xsetroot -name "  $(wfi)$(kyb)   $(dte)   "
    sleep 1s
done
