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

if [ -e "$roms2_path" ]; then
  cd $roms2_path
  if [ -e "$m8_path" ]; then
    cd $m8_path
  else
    cd $m8_orgpath
  fi
else
  cd $roms_path
  if [ -e "$m8_path" ]; then
    cd $m8_path
  else
    cd $m8_orgpath
  fi
fi

# set cpu governor to powersave to minimize audio "crackles"
#echo "powersave" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# alsaloop_wait will run in background and try to create the loopback 
# if it can't be created before m8c runs. Useful for wait_for_device=true. 
#./alsaloop_wait &
alsaloop -P hw:2,0 -C hw:1,0 -t 200000 -A 5 --rate 44100 --sync=0 -T -1 -d
sleep 1
./_m8c/m8c

pkill alsaloop

# Uncomment the following lines to enable wi-fi
#sudo modprobe -i mt7601u
#sudo sed -i '/blacklist mt7601u/d' /etc/modprobe.d/blacklist.conf
#printf "\n\n\n\e[32mWifi has been enabled.\n"
