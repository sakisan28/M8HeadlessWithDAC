#!/usr/bin/bash

M8=$(aconnect -i -l | awk '/M8/{ print substr($2,1,length($2)-1);exit }')

aconnect -o -l | awk -v M8=${M8} '/^client/ && !/(System|Midi\ Through|M8)/{system("aconnect " substr($2,1,length($2)-1) ($0~/Launchpad\ Mini/?":1":"")" " M8);}' 2>&1
