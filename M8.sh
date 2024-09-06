#!/bin/bash

# Uncomment the following lines to disable wi-fi
#sudo modprobe -r mt7601u
#sudo sed -i '$ablacklist mt7601u' /etc/modprobe.d/blacklist.conf
#printf "\n\n\n\e[32mWifi has been disabled.\n"

sed -i "/^idle_ms=/s/=.*/=25/" ~/.local/share/m8c/config.ini

cd $(dirname $0)

# set cpu governor to powersave to minimize audio "crackles"
#echo "powersave" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
#echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

aplay -l | grep 'rockchiprk817co'

if [ $? -eq 0 ]
then
#ArkOS
    alsaloop -P hw:rockchiprk817co,0 -C hw:M8,0 -t 200000 -A 5 --rate 44100 --sync=1 -T -1 -d
    sleep 1
    ./_m8c/m8c
    pkill alsaloop
else
#ROCKNIX
    M8=$(pa-info 2>&1 | awk '/Name: alsa_input\.usb-DirtyWave_M8_[0-9\-].*\.analog-stereo/{print $2;exit}')
    SPK=$(pa-info 2>&1 | awk '/Name: alsa_output\._sys_devices_platform_.*HiFi__Headphones__sink/{print $2;exit}')
    pactl set-default-source ${M8}
    pactl set-default-sink ${SPK}
    pactl load-module module-loopback source=${M8} sink=${SPK} latency_msec=200 format=s16le rate=44100 channels=2
    sleep 2
    ./_m8c/m8c
    pactl unload-module module-loopback
fi

# Uncomment the following lines to enable wi-fi
#sudo modprobe -i mt7601u
#sudo sed -i '/blacklist mt7601u/d' /etc/modprobe.d/blacklist.conf
#printf "\n\n\n\e[32mWifi has been enabled.\n"
