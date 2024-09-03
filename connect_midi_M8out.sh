#!/usr/bin/bash
M8=$(aconnect -o -l | awk '/M8/{ print substr($2,1,length($2)-1);exit }')

aconnect -i -l | awk -v M8=${M8} '/^client/ && !/(System|Midi\ Through|M8)/{system("aconnect " M8 " " substr($2,1,length($2)-1));}' 2>&1
