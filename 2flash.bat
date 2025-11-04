@echo off
title %~n0
rem Tested on v4.10.0 [esptool-v4.10.0-windows-amd64.zip]

if exist esphaku.full.bin (
	echo esphaku.full.bin
	esptool --chip esp8266 write_flash 0x00000000 esphaku.full.bin
) else (
	echo esphaku.bin
	esptool --chip esp8266 write_flash 0x00000000 esphaku.bin
	echo esphaku.ffs
	esptool --chip esp8266 write_flash 0x00100000 esphaku.ffs
)

pause
