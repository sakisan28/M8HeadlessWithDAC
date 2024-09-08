#!/bin/bash

sed -i "/^idle_ms=/s/=.*/=25/" ~/.local/share/m8c/config.ini

cd $(dirname $0)

aplay -l | grep 'rockchiprk817co'

if [ $? -eq 0 ]
then
#ArkOS
    USBDEV=$(aplay -l|grep '\[USB Audio\]'|grep -v 'M8 \[M8\]'|awk '{print $3;exit}')
    sudo nice --19 alsaloop -P plughw:${USBDEV},0 -C hw:M8,0 -t 16000 -A 5 --rate 44100 --sync=1 -T -1 -d
    sleep 1
    ./_m8c/m8c
    sudo pkill alsaloop
else
#ROCKNIX
    M8=$(pactl list sources short 2>&1 | awk '/alsa_input\.usb-DirtyWave_M8/{print $1;exit}')
    USBDEV=$(pactl list sinks short|grep 'alsa_output\.usb'|grep -v 'DirtyWave_M8'|awk '{print $1;exit}')
    pactl set-default-source ${M8}
    pactl set-default-sink ${USBDEV}
    pactl load-module module-loopback source=${M8} sink=${USBDEV} latency_msec=16 format=s16le rate=44100 channels=2
    sleep 2
    pgrep pipewire | awk '{system("renice -n -19 " $1)}'
    ./_m8c/m8c
    pactl unload-module module-loopback
fi
