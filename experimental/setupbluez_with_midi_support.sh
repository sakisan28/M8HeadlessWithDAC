#!/usr/bin/bash
echo ''
echo ''
echo 'WARNING THIS IS EXPERIMENTAL SCRIPT.'
echo 'THIS SCRIPT REPLACE NORMAL VERSION OF BLUEZ 5.50 WITH MIDI SUPPORT OVER SYSTEM BLUEZ.'
echo 'NOT EXTENSIVELY TESTED.'
echo 'You have to have knowledge of Linux application building.'
echo 'WAIT 60 SECONDS TO CONTINUE...'
sleep 60

#ArkOS's bluez is not support midi.
#This script replace bluetooth components.
#Usage: on menu bluetooth select connect new device midi device
#check 'aconnect -l'
#run 'midi_connect.sh' script

sudo apt update
#sudo apt -y upgrade


####################################################
#FOLOWING INSTALL SCRIPT FOR DEV TOOLS IS VERY DIRTY
#IF YOU ARE TRUE DEVELOPPER TRY https://github.com/christianhaitian/arkos/tree/main/Headers
####################################################
sudo apt -y reinstall build-essential linux-libc-dev libc6-dev libglib2.0-dev libdbus-glib-1-dev libdbus-1-dev libasound2-dev libudev-dev
sudo apt -y install libical-dev libreadline-dev

wget https://mirrors.edge.kernel.org/pub/linux/bluetooth/bluez-5.50.tar.xz
tar xvf bluez-5.50.tar.xz
cd bluez-5.50

./configure --prefix=/usr --enable-midi --disable-tools --disable-cups --disable-obex --disable-manpages --disable-debug  --sbindir=/usr/lib --libexecdir=/usr/lib --mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var  --with-systemdsystemunitdir=/etc/systemd/system

make

sudo make install-exec
sudo cp /usr/bin/mpris-proxy /usr/lib/bluetooth
