@echo off
title %~n0
if not exist data (
	echo Error: data dir not found!
	pause
	exit
)

cd data
if exist go rd /q /s go
if exist henlo rd /q /s henlo
if exist release rd /q /s release
cd ..

if exist esphaku.full.bin del /q esphaku.full.bin
if exist esphaku.bin del /q esphaku.bin
if exist esphaku.ffs del /q esphaku.ffs

pause
