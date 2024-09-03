#!/usr/bin/bash

m8=$(aconnect -i -l | awk '/M8/{ print substr($2,1,length($2)-1);exit }')
fluid=$(aconnect -o -l | awk '/FLUID/{ print substr($2,1,length($2)-1);exit }')

pkill fluidsynth

echo "aconnect -d $m8 $fluid"
aconnect -d ${m8} ${fluid}

