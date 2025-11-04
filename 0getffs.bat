@echo off
title %~n0
where /q wget.exe
if %errorlevel% neq 0 (
	echo Error: wget.exe not found!
	pause
	exit
)
if not exist data (
	echo Error: data dir not found!
	pause
	exit
)

cd data

if exist go rmdir /q /s go
mkdir go
cd go
	for %%l in (henkaku.bin, payload.js, pkg/henkaku.skprx, pkg/henkaku.suprx, pkg/taihen.skprx) do (
		echo Loading %%l...
		wget -q --show-progress --tries=inf http://vitawiki.xyz/go/%%l
	)
	echo Loading exploit.html...
	wget -q --show-progress --tries=inf -O index.html http://vitawiki.xyz/go/exploit.html
	REM wget -q --show-progress --tries=inf http://vitawiki.xyz/go/henkaku.bin
	REM wget -q --show-progress --tries=inf http://vitawiki.xyz/go/payload.js
	REM wget -q --show-progress --tries=inf http://vitawiki.xyz/go/pkg/henkaku.skprx
	REM wget -q --show-progress --tries=inf http://vitawiki.xyz/go/pkg/henkaku.suprx
	REM wget -q --show-progress --tries=inf http://vitawiki.xyz/go/pkg/taihen.skprx
cd ..
rmdir go
if not exist go (
	echo Error: go dir not found!
	pause
	exit
)

if exist tf rmdir /q /s tf
mkdir tf
cd tf
	wget -q --show-progress --tries=inf http://vitawiki.xyz/tf/henkaku.bin
cd ..
rmdir tf
if not exist tf (
	echo Error: tf dir not found!
	pause
	exit
)

if exist henlo rmdir /q /s henlo
mkdir henlo
cd henlo
	for %%l in (exploit.js, index.html, jsos.js, kernel.js, offsets.js, payload.bin) do (
		echo Loading %%l...
		wget -q --show-progress --tries=inf http://vitawiki.xyz/henlo/%%l
	)
	REM wget -q --show-progress --tries=inf http://vitawiki.xyz/henlo/exploit.js
	REM wget -q --show-progress --tries=inf http://vitawiki.xyz/henlo/index.html
	REM wget -q --show-progress --tries=inf http://vitawiki.xyz/henlo/jsos.js
	REM wget -q --show-progress --tries=inf http://vitawiki.xyz/henlo/kernel.js
	REM wget -q --show-progress --tries=inf http://vitawiki.xyz/henlo/offsets.js
	REM wget -q --show-progress --tries=inf http://vitawiki.xyz/henlo/payload.bin
cd ..
rmdir henlo
if not exist henlo (
	echo Error: henlo dir not found!
	pause
	exit
)

if exist release rmdir /q /s release
mkdir release
cd release
	wget -q --show-progress --tries=inf http://vitawiki.xyz/go/pkg/sce_sys/livearea/contents/install_button.png
	wget -q --show-progress --tries=inf http://vitawiki.xyz/release/bg.png
	wget -q --show-progress --tries=inf http://vitawiki.xyz/release/eboot.bin
	wget -q --show-progress --tries=inf http://vitawiki.xyz/release/head.bin
	wget -q --show-progress --tries=inf http://vitawiki.xyz/release/icon0.png
	wget -q --show-progress --tries=inf http://vitawiki.xyz/release/param.sfo
	wget -q --show-progress --tries=inf http://vitawiki.xyz/release/startup.png
	wget -q --show-progress --tries=inf http://vitawiki.xyz/release/template.xml

cd ..
rmdir release
if not exist release (
	echo Error: release dir not found!
	pause
	exit
)

pause
