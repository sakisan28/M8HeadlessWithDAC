#!/bin/bash

sed -i "/^idle_ms=/s/=.*/=25/" ~/.local/share/m8c/config.ini

cd $(dirname $0)

aplay -l | grep 'rockchiprk817co'

if [ $? -eq 0 ]
then
#ArkOS
    alsaloop -P hw:rockchiprk817co,0 -C hw:M8,0 -t 200000 -A 5 --rate 44100 --sync=1 -T -1 -d
    sleep 1
    USBDEV=$(arecord -l|grep '\[USB Audio\]'|grep -v 'M8 \[M8\]'|awk '{print $3;exit}')
    alsaloop -P hw:M8,0 -C hw:${USBDEV},0 -t 200000 -A 5 --rate 44100 --sync=1 -T -1 -d
    sleep 1
    ./_m8c/m8c
    pkill alsaloop
else
#ROCKNIX
    SPK=$(pactl list sinks short 2>&1 | awk '/alsa_output\._sys_devices_platform_.*HiFi__Headphones__sink/{print $1;exit}')
    M8=$(pactl list sources short 2>&1 | awk '/alsa_input\.usb-DirtyWave_M8/{print $1;exit}')
    USBDEV=$(pactl list sources short|grep 'alsa_input\.usb'|grep -v 'DirtyWave_M8'|awk '{print $1;exit}')
    pactl set-default-source ${M8}
    pactl set-default-sink ${SPK}
    pactl load-module module-loopback source=${M8} sink=${SPK} latency_msec=200 format=s16le rate=44100 channels=2
    sleep 2
    pactl load-module module-loopback source=${USBDEV} sink=${M8} latency_msec=200 format=s16le rate=44100 channels=2
    sleep 2
    ./_m8c/m8c
    pactl unload-module module-loopback
fi
