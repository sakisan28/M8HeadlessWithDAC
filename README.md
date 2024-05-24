# M8HeadlessWithDAC
M8 Headless with game console (RG351, R36S etc...) output to USBDAC.

**for "1M8ARK" archive on YouTube**
[https://www.youtube.com/watch?v=tt95ZG6W8hM](https://www.youtube.com/watch?v=tt95ZG6W8hM)

for ARKOS.

  
# Usage  
Copy M8USBDAC.sh to your m8c directory (one of /roms/ports/M8, /roms/1M8ARK, /roms2/ports/M8, /roms2/1M8ARK).  
  
|File|Description|
|---|---|
|M8USBDAC.sh|output to USBDAC|  
|M8USBDAC_rev.sh|output to USBDAC, detection order reverse version.|  
|M8USBDAC_by_name.sh|If your USBDAC device named 'CODEC', this version is mostly stable.|  
|M8_SPKOUT_USBIN.sh|output to game console speaker and "audio in" from USB audio interface.|  
|M8_USBINOUT.sh|for audio interface in/out.|  
|showdevices.sh|show devide ID (push button to exit).|  
  
Early, specific directory versions are marged main M8USBDAC.sh.  
Original 'power save' codes are commented out.  

---
  

**Detail**  
In script, you can see following line:  
alsaloop -P hw:2,0 -C hw:1,0 ...  
  
'-P hw:2,0' means playback device set to device ID 2.  
'-C hw:1,0' means capture device set to device ID 1.  
  
alsaloop works pass stream '-C' to '-P' devices.  

Ordinaly, device IDs are:  
0: Game console internal audio  
1: M8 Headless  
2: USB audio device  

These IDs depend device connecting order...  

The device id '7' is set by ARKOS, it may same as device '2'.  

M8 Headless has device name 'M8', you can write the line:  
alsaloop -P hw:2,0 -C hw:M8,0 ...  
  
  
