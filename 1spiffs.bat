@echo off
title %~n0

if exist esphaku.ino.nodemcu.bin (
	if exist esphaku.bin del /q esphaku.bin
	ren esphaku.ino.nodemcu.bin esphaku.bin
)
if not exist esphaku.bin (
	echo Error: esphaku.bin is missing!
	pause
	exit
)
rem Tested on v0.2.0 [3.1.0-gcc10.3-e5f9fec]
where /q mkspiffs.exe
if %errorlevel% neq 0 (
	echo Error: mkspiffs.exe not found!
	pause
	exit
)
if exist esphaku.ffs del /q esphaku.ffs
mkspiffs -c data -b 8192 -s 3125248 esphaku.ffs
if not exist esphaku.ffs (
	echo Error: esphaku.ffs is missing!
	pause
	exit
)

if exist esphaku.full.bin (
	del /q esphaku.full.bin
)
where /q python3.exe
if %errorlevel% neq 0 (
	echo Warning: python3.exe not found!
) else (
	python3 mkfirm.py
)

pause
