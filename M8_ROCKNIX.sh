#/bin/bash

cd $(dirname $0)

#./alsaloop -P hw:rk817ext,0 -C hw:M8,0 -t 200000 -A 5 --rate 44100 --sync=0 -T -1 -d

M8=$(pa-info 2>&1 | awk '/Name: alsa_input\.usb-DirtyWave_M8_[0-9\-].*\.analog-stereo/{print $2;exit}')
SPK=$(pa-info 2>&1 | awk '/Name: alsa_output\._sys_devices_platform_.*HiFi__Headphones__sink/{print $2;exit}')
pactl set-default-source ${M8}
pactl set-default-sink ${SPK}
pactl load-module module-loopback source=${M8} sink=${SPK} latency_msec=200 format=s16le rate=44100 channels=2
sleep 2
./_m8c/m8c

pactl unload-module module-loopback

#pkill alsaloop
