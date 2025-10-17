@echo off

if exist esphaku.ino.nodemcu.bin (
	if exist esphaku.bin del /q esphaku.bin
	ren esphaku.ino.nodemcu.bin esphaku.bin
)

if exist esphaku.ffs del /q esphaku.ffs
rem Tested on v0.2.0 [3.1.0-gcc10.3-e5f9fec]
mkspiffs -c data -b 8192 -s 3125248 esphaku.ffs

rem Tested on v4.10.0 [esptool-v4.10.0-windows-amd64.zip]
esptool --chip esp8266 write_flash 0x00000000 esphaku.bin
esptool --chip esp8266 write_flash 0x00100000 esphaku.ffs

pause