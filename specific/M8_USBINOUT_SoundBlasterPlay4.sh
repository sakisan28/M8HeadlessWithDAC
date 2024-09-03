#!/bin/bash

# Uncomment the following lines to disable wi-fi
#sudo modprobe -r mt7601u
#sudo sed -i '$ablacklist mt7601u' /etc/modprobe.d/blacklist.conf
#printf "\n\n\n\e[32mWifi has been disabled.\n"


#/opt/system/Advanced/'Disable Wifi.sh' &

sed -i "/^idle_ms=/s/=.*/=25/" ~/.local/share/m8c/config.ini

cd $(dirname $0)

# set cpu governor to powersave to minimize audio "crackles"
#echo "powersave" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# alsaloop_wait will run in background and try to create the loopback 
# if it can't be created before m8c runs. Useful for wait_for_device=true. 
#./alsaloop_wait &

alsaloop -P hw:S4,0 -C hw:M8,0 -t 200000 -A 5 --rate 44100 --sync=0 -T -1 -d
alsaloop -P hw:M8,0 -C hw:S4,0 -t 200000 -A 5 --rate 44100 --sync=0 -T -1 -d
#alsaloop -P hw:M8,0 -C hw:T8,0 -t 200000 -A 5 --rate 44100 --sync=0 -T -1 -d
sleep 1

./_m8c/m8c

pkill alsaloop

# Uncomment the following lines to enable wi-fi
#sudo modprobe -i mt7601u
#sudo sed -i '/blacklist mt7601u/d' /etc/modprobe.d/blacklist.conf
#printf "\n\n\n\e[32mWifi has been enabled.\n"

#/opt/system/Advanced/'Enable Wifi.sh'
