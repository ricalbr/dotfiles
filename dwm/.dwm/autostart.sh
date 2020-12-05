#! /bin/bash

compton &
nitrogen --restore &
xset +fp $HOME/.local/share/fonts &
xset fp rehash &

dte(){
    dte="$(date "+%a, %d/%m/%y %H:%M")"
    echo -e "$dte"
}


while true; do
    xsetroot -name "$(dte)   "
    sleep 1m
done
