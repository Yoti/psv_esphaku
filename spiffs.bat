@echo off

setlocal
set PATH=%PATH%;%LOCALAPPDATA%\Arduino15\packages\esp8266\tools\mkspiffs\0.2.0

if exist esphaku.bin del /q esphaku.bin
ren esphaku.ino.nodemcu.bin esphaku.bin

if exist esphaku.ffs del /q esphaku.ffs
mkspiffs -c data -b 8192 -s 3125248 esphaku.ffs

pause