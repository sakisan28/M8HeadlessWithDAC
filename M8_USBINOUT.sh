#!/bin/bash

sed -i "/^idle_ms=/s/=.*/=25/" ~/.local/share/m8c/config.ini

cd $(dirname $0)

aplay -l | grep 'rockchiprk817co'

if [ $? -eq 0 ]
then
#ArkOS
    USBOUT=$(aplay -l|grep '\[USB Audio\]'|grep -v 'M8 \[M8\]'|awk '{print $3;exit}')
    alsaloop -P plughw:${USBOUT},0 -C hw:M8,0 -t 200000 -A 5 --rate 44100 --sync=1 -T -1 -d
    sleep 1
    USBIN=$(arecord -l|grep '\[USB Audio\]'|grep -v 'M8 \[M8\]'|awk '{print $3;exit}')
    alsaloop -P hw:M8,0 -C hw:${USBIN},0 -t 200000 -A 5 --rate 44100 --sync=1 -T -1 -d
    sleep 1
    ./_m8c/m8c
    pkill alsaloop
else
#ROCKNIX
    M8IN=$(pactl list sinks short 2>&1 | awk '/alsa_output\.usb-DirtyWave_M8/{print $1;exit}')
    M8OUT=$(pactl list sources short 2>&1 | awk '/alsa_input\.usb-DirtyWave_M8/{print $1;exit}')
    USBOUT=$(pactl list sinks short 2>&1 |grep 'alsa_output\.usb'|grep -v 'DirtyWave_M8'|awk '{print $1;exit}')
    USBIN=$(pactl list sources short 2>&1 |grep 'alsa_input\.usb'|grep -v 'DirtyWave_M8'|awk '{print $1;exit}')
    pactl set-default-source ${M8OUT}
    pactl set-default-sink ${USBOUT}
    pactl load-module module-loopback source=${M8OUT} sink=${USBOUT} latency_msec=200 format=s16le rate=44100 channels=2 source_dont_move=true sink_dont_move=true
    sleep 2
    pactl load-module module-loopback source=${USBIN} sink=${M8IN} latency_msec=200 format=s16le rate=44100 channels=2 source_dont_move=true sink_dont_move=true
    sleep 2
    ./_m8c/m8c
    pactl unload-module module-loopback
fi
