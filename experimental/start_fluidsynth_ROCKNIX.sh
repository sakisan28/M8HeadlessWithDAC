#!/usr/bin/bash

M8=$(pa-info 2>&1 | awk '/Name: alsa_output\.usb-DirtyWave_M8_[0-9\-].*\.analog-stereo/{print $2;exit}')

fluidsynth -s -i -a pulseaudio -o audio.pulseaudio.device=${M8} -m alsa_seq -g 1.0 /usr/share/soundfonts/GeneralUser.sf2 &

sleep 2

m8=$(aconnect -i -l | awk '/M8/{ print substr($2,1,length($2)-1);exit }')
fluid=$(aconnect -o -l | awk '/FLUID/{ print substr($2,1,length($2)-1);exit }')

aconnect ${m8} ${fluid}
