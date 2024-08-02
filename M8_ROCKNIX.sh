#/bin/bash

cd /storage/roms/ports/M8

#./alsaloop -P hw:rk817ext,0 -C hw:M8,0 -t 200000 -A 5 --rate 44100 --sync=0 -T -1 -d

pactl set-default-source alsa_input.usb-DirtyWave_M8_15208230-02.analog-stereo
pactl set-default-sink alsa_output._sys_devices_platform_sound_sound_card1.HiFi__Headphones__sink
pactl load-module module-loopback source=alsa_input.usb-DirtyWave_M8_15208230-02.analog-stereo alsa_output._sys_devices_platform_sound_sound_card1.HiFi__Headphones__sink
sleep 2
./_m8c/m8c

pactl unload-module module-loopback

#pkill alsaloop
