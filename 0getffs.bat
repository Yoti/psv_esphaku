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
rem		echo Loading %%l...
		wget -q --show-progress --tries=inf http://vitawiki.xyz/go/%%l
	)
rem	echo Loading exploit.html...
	wget -q --show-progress --tries=inf -O index.html http://vitawiki.xyz/go/exploit.html
cd ..
rmdir go>nul 2>&1
if not exist go (
	echo Error: go dir not found!
	pause
	exit
)

if exist tf rmdir /q /s tf
mkdir tf
cd tf
	for %%l in (henkaku.bin, payload.js, pkg/gamesd.skprx, pkg/henkaku.skprx, pkg/henkaku.suprx, pkg/taihen.skprx) do (
rem		echo Loading %%l...
		wget -q --show-progress --tries=inf http://vitawiki.xyz/tf/%%l
	)
rem	echo Loading exploit.html...
	wget -q --show-progress --tries=inf -O index.html http://vitawiki.xyz/tf/exploit.html
cd ..
rmdir tf>nul 2>&1
if not exist tf (
	echo Error: tf dir not found!
	pause
	exit
)

if exist henlo rmdir /q /s henlo
mkdir henlo
cd henlo
	for %%l in (exploit.js, index.html, jsos.js, kernel.js, offsets.js, payload.bin) do (
rem		echo Loading %%l...
		wget -q --show-progress --tries=inf http://vitawiki.xyz/henlo/%%l
	)
cd ..
rmdir henlo>nul 2>&1
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
rem	wget -q --show-progress --tries=inf http://fjp01.psp2.update.playstation.net/update/psp2/list/jp/psp2-updatelist.xml
	for %%r in (au, cn, eu, jp, kr, mx, ru, sa, tw, uk, us) do (
		if exist %%r rmdir /s /q %%r
		mkdir %%r
		cd %%r
		wget -q --show-progress --tries=inf http://f%%r01.psp2.update.playstation.net/update/psp2/list/%%r/psp2-updatelist.xml
		cd ..
	)
cd ..
rmdir release>nul 2>&1
if not exist release (
	echo Error: release dir not found!
	pause
	exit
)

pause
