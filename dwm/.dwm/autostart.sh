#! /bin/bash

compton &
nitrogen --restore &


    dte(){
        dte="$(date "+%a, %d/%m/%y %H:%M")"
        echo -e "$dte"
    }


while true; do
    xsetroot -name "$(dte)   "
    sleep 1m
done
