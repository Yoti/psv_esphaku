@echo off
title %~n0

cd data
if exist go rd /q /s go
if exist henlo rd /q /s henlo
if exist release rd /q /s release
cd ..

if exist esphaku.bin del /q esphaku.bin
if exist esphaku.ffs del /q esphaku.ffs

pause
