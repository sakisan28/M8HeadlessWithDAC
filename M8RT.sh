#!/bin/bash

# Uncomment the following lines to disable wi-fi
#sudo modprobe -r mt7601u
#sudo sed -i '$ablacklist mt7601u' /etc/modprobe.d/blacklist.conf
#printf "\n\n\n\e[32mWifi has been disabled.\n"

sed -i "/^idle_ms=/s/=.*/=25/" ~/.local/share/m8c/config.ini

m8_orgpath=ports/M8
m8_path=1M8ARK
roms2_path=/roms2
roms_path=/roms
path1=$roms_path/$m8_orgpath
path2=$roms2_path/$m8_orgpath
path3=$roms_path/$m8_path
path4=$roms2_path/$m8_path

if [ -e "$path1" ]; then
  cd $path1
elif [ -e "$path2" ]; then
  cd $path2
elif [ -e "$path3" ]; then
  cd $path3
elif [ -e "$path4" ]; then
  cd $path4
fi

# set cpu governor to powersave to minimize audio "crackles"
#echo "powersave" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
#echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# alsaloop_wait will run in background and try to create the loopback 
# if it can't be created before m8c runs. Useful for wait_for_device=true. 
#./alsaloop_wait &
alsaloop -P hw:rockchiprk817co,0 -C hw:M8,0 -t 16000 -A 5 --rate 44100 --sync=1 -T -1 -d
sleep 1
./_m8c/m8c

pkill alsaloop

# Uncomment the following lines to enable wi-fi
#sudo modprobe -i mt7601u
#sudo sed -i '/blacklist mt7601u/d' /etc/modprobe.d/blacklist.conf
#printf "\n\n\n\e[32mWifi has been enabled.\n"
