#!/usr/bin/bash

fluidsynth -s -i -a alsa -o audio.alsa.device=hw:M8,0 -m alsa_seq /usr/share/sounds/sf3/default-GM.sf3 &
sleep 2

m8=$(aconnect -i -l | awk '/M8/{ print substr($2,1,length($2)-1);exit }')
fluid=$(aconnect -o -l | awk '/FLUID/{ print substr($2,1,length($2)-1);exit }')

echo "aconnect $fluid $m8"
aconnect ${m8} ${fluid}
