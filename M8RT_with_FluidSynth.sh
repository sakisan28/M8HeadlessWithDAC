#!/bin/bash

sed -i "/^idle_ms=/s/=.*/=25/" ~/.local/share/m8c/config.ini

cd $(dirname $0)

aplay -l | grep 'rockchiprk817co'

if [ $? -eq 0 ]
then
#ArkOS
    fluidsynth -s -i -g 1.0 -a alsa -o audio.alsa.device=hw:M8,0 -m alsa_seq -g 1.0 /usr/share/sounds/sf3/default-GM.sf3 &
    sleep 5
    m8=$(aconnect -i -l | awk '/M8/{ print substr($2,1,length($2)-1);exit }')
    fluid=$(aconnect -o -l | awk '/FLUID/{ print substr($2,1,length($2)-1);exit }')
    aconnect ${m8} ${fluid}
    sleep 1

    sudo nice --19 alsaloop -P hw:rockchiprk817co,0 -C hw:M8,0 -t 16000 -A 5 --rate 44100 --sync=1 -T -1 -d
    sleep 1
    ./_m8c/m8c
    sudo pkill alsaloop
    pkill fluidsynth
    aconnect -d ${m8} ${fluid}
else
#ROCKNIX
    M8=$(pactl list sources short 2>&1 | awk '/alsa_input\.usb-DirtyWave_M8/{print $1;exit}')
    fluidsynth -s -i -a pulseaudio -o audio.pulseaudio.device=${M8} -m alsa_seq -g 1.0 /usr/share/soundfonts/GeneralUser.sf2 &
    sleep 5
    m8midi=$(aconnect -i -l | awk '/M8/{ print substr($2,1,length($2)-1);exit }')
    fluid=$(aconnect -o -l | awk '/FLUID/{ print substr($2,1,length($2)-1);exit }')
    aconnect ${m8midi} ${fluid}
    sleep 1

    SPK=$(pactl list sinks short 2>&1 | awk '/alsa_output\._sys_devices_platform_.*HiFi__Headphones__sink/{print $1;exit}')
    pactl set-default-source ${M8}
    pactl set-default-sink ${SPK}
    pactl load-module module-loopback source=${M8} sink=${SPK} latency_msec=16 format=s16le rate=44100 channels=2
    sleep 2
    pgrep pipewire | awk '{system("renice -n -19 " $1)}'
    ./_m8c/m8c
    pactl unload-module module-loopback
    pkill fluidsynth
    aconnect -d ${m8midi} ${fluid}
fi
