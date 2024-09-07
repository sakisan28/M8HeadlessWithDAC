#!/bin/bash

sudo rg351p-js2xbox --silent -t oga_joypad &
sleep 0.5
sudo ln -s /dev/input/event4 /dev/input/by-path/platform-odroidgo2-joypad-event-joystick
sleep 0.5
sudo chmod 777 /dev/input/by-path/platform-odroidgo2-joypad-event-joystick

str=$(aplay -l)
str+=$'\n----------------------------------------\n'
str+=$(arecord -l)
str+=$'\n\n'

echo $str
LD_LIBRARY_PATH=/usr/local/bin msgbox "$str"

sudo kill $(pidof rg351p-js2xbox)
sudo rm /dev/input/by-path/platform-odroidgo2-joypad-event-joystick
