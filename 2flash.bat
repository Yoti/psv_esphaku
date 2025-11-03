echo off
title %~n0
rem Tested on v4.10.0 [esptool-v4.10.0-windows-amd64.zip]

python3 mkfirm.py

if exist esphaku.full.bin (
	esptool --chip esp8266 write_flash 0x00000000 esphaku.full.bin
) else (
	esptool --chip esp8266 write_flash 0x00000000 esphaku.bin
	esptool --chip esp8266 write_flash 0x00100000 esphaku.ffs
)

pause