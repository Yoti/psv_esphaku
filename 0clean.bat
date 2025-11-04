@echo off
title %~n0
if not exist data (
	echo Error: data dir not found!
	pause
	exit
)

cd data
if exist go rmdir /q /s go
if exist tf rmdir /q /s tf
if exist henlo rmdir /q /s henlo
if exist release rmdir /q /s release
cd ..

if exist esphaku.bin del /q esphaku.bin
if exist esphaku.ffs del /q esphaku.ffs
if exist esphaku.full.bin del /q esphaku.full.bin

pause
