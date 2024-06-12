#!/usr/bin/bash

#ArkOS's bluez is not support midi.
#This script replace bluetooth components.
#WARNING THIS IS EXPERIMENTAL SCRIPT.
#You have to have knowledge of Linux application building.
#Usage: on menu bluetooth select connect new device midi device
#check 'aconnect -l'
#run 'midi_connect.sh' script

sudo apt update
sudo apt upgrade

sudo apt reinstall build-essential linux-libc-dev libc6-dev libdbus-1-dev
sudo apt install git autotools-dev flex bison libglib2.0-dev libudev-dev libical-dev libreadline-dev python3-docutils libjson-c-dev libasound2-dev

wget https://mirrors.edge.kernel.org/pub/linux/bluetooth/bluez-5.50.tar.xz
tar xvf bluez-5.50.tar.xz
cd bluez-5.50

./configure --prefix=/usr --enable-midi --sbindir=/usr/lib --libexecdir=/usr/lib --mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var  --with-systemdsystemunitdir=/etc/systemd/system

echo "#include <linux/sockios.h>" > header.tmp
mv tools/rctest.c tools/rctest.c.ORG
cat header.tmp tools/rctest.c.ORG > tools/rctest.c
mv tools/l2test.c tools/l2test.c.ORG
cat header.tmp tools/l2test.c.ORG > tools/l2test.c

make

sudo make install-exec
sudo cp /usr/bin/mpris-proxy /usr/lib/bluetooth
