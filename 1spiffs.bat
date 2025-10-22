@echo off

if exist esphaku.ino.nodemcu.bin (
	if exist esphaku.bin del /q esphaku.bin
	ren esphaku.ino.nodemcu.bin esphaku.bin
)

if exist esphaku.ffs del /q esphaku.ffs
rem Tested on v0.2.0 [3.1.0-gcc10.3-e5f9fec]
mkspiffs -c data -b 8192 -s 3125248 esphaku.ffs

pause