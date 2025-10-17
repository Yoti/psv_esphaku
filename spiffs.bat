@echo off

if exist esphaku.ino.nodemcu.bin (
	if exist esphaku.bin del /q esphaku.bin
	ren esphaku.ino.nodemcu.bin esphaku.bin
)

if exist esphaku.ffs del /q esphaku.ffs
mkspiffs -c data -b 8192 -s 3125248 esphaku.ffs

esptool --chip esp8266 write_flash 0x00000000 esphaku.bin
esptool --chip esp8266 write_flash 0x00100000 esphaku.ffs

pause