#/bin/bash

cd /storage/roms/ports/M8

#./alsaloop -P hw:rk817ext,0 -C hw:M8,0 -t 200000 -A 5 --rate 44100 --sync=0 -T -1 -d

M8=$(pa-info 2>&1 | awk '/alsa_input\.usb-DirtyWave_M8_[0-9\-].*\.analog-stereo/{print $3;exit}')
pactl set-default-source ${M8}
pactl set-default-sink alsa_output._sys_devices_platform_sound_sound_card1.HiFi__Headphones__sink
pactl load-module module-loopback source=${M8} alsa_output._sys_devices_platform_sound_sound_card1.HiFi__Headphones__sink
sleep 2
./_m8c/m8c

pactl unload-module module-loopback

#pkill alsaloop
