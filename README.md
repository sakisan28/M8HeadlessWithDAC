# M8HeadlessWithDAC
Dirtywave M8 Headless with game console (RG351, R36S etc...) scripts for use USB audio(aka DAC).

# Install  
Install m8c archive called '1M8ARK'.  
*for M8 Version 4.0 on discord search '1M8ARK'*   
download link:  
https://github.com/miotislucifugis/m8c_arkOs_4.0  
  
Setup 1M8ARK m8c.  
Or, If you wish build m8c from source, refer experimental/howto- text.
  
Tested on ArkOS and ROCKNIX.  

**On ROCKNIX, I recomend to use RK3566 machine.**  
  
**Ver 2.0 ROCKNIX scripts are unified main scripts.**  

  
# Usage  
ArkOS  
Copy M8_USBDAC.sh or some .sh files to your m8c directory (one of /roms/ports/M8 (ports menu), /roms/1M8ARK (run by filemanager or edit es_systems), /roms/tools (Options-Tools menu). You can also use roms2.

ROCKNIX  
Copy M8_USBDAC.sh or some .sh files to /storage/roms/ports/M8.  
  
Connect Teensy and run 'M8'.  
  
|File|Description|
|---|---|
|M8.sh|standard M8 script.|  
|M8RT.sh|low latency realtime version, sometime glitchy|  
|M8_USBDAC.sh|output to USBDAC|  
|M8_SPKOUT_USBIN.sh|output to game console speaker and "audio in" from USB audio interface.|  
|M8_USBINOUT.sh|for audio interface in/out.|  
|showdevices.sh|show device ID (push button to exit).|  
  
---
  

**Detail**  
In script, you can see following line:  
alsaloop -P hw:2,0 -C hw:1,0 ...  
  
'-P hw:2,0' means playback device set to device ID 2.  
'-C hw:1,0' means capture device set to device ID 1.  
  
alsaloop works pass stream '-C' to '-P' devices.  

Ordinary, device IDs are:  
0: Game console internal audio  
1: M8 Headless  
2: USB audio device  

These IDs depend device connecting order...  

The device id '7' is set by ARKOS, it may same as device '2'.  

M8 Headless has device name 'M8', you can write the line:  
alsaloop -P hw:2,0 -C hw:M8,0 ...  

---
**Sample setting**  
Internal speaker by device name  
alsaloop -P hw:rockchiprk817co,0 -C hw:M8,0 ...  
    
Use --sync=1 for timing but sometime drop sample.  
alsaloop ... -t 200000 -A 5 --rate 44100 --sync=1 -T -1 -d  
  
If USB hardware default is not 44100, use plughw: instead of hw:  
alsaloop -P plughw:MC101,0 -C hw:M8,0 -t 200000 --rate 44100 -A 5 -T -1 -d  
  
---
**Specific**  (**v2.0 obsolete**, for just  example)  
Roland MC101  
Roland T8  
Device named 'CODEC'  
Device named 'Dock'  
Device number 3 (for Powkiddy RGB30)  

---
*Experimental*  
fluidsynth: start fluidsynth(Soundfont) and synth output to M8 USB in.  You can use GM synth on M8's 'EXTERNAL' instrument or Mixer USB channel.   
befor run M8, run start_fluidsynth, then run M8 to go.  
  
alsaloop and some tools for ROCKNIX (test build)  
experimental_m8_rocknix.zip  
  
Bluez MIDI support: sample script for rebuild Bluez with MIDI support.  
Tested BLE MIDI decices:  
Yamaha UD-BT01  
Korg MicroKey2 Air  
CME Widi Master, Widi Bud Pro  

---
# Links
ArkOS [https://github.com/christianhaitian/arkos/wiki](https://github.com/christianhaitian/arkos/wiki)  
1M8ARK on YouTube [https://www.youtube.com/watch?v=tt95ZG6W8hM](https://www.youtube.com/watch?v=tt95ZG6W8hM)  
rg351_m8c [https://github.com/jasonporritt/rg351_m8c](https://github.com/jasonporritt/rg351_m8c)  
m8c [https://github.com/laamaa/m8c/](https://github.com/laamaa/m8c/)  
M8 Headless Firmware [https://github.com/Dirtywave/M8HeadlessFirmware](https://github.com/Dirtywave/M8HeadlessFirmware)  
Dirtywave [https://dirtywave.com/](https://dirtywave.com/)  
