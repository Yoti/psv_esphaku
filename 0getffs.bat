@echo off
title %~n0
cd data

if exist go rd /q /s go
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

if exist henlo rd /q /s henlo
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

if exist release rd /q /s release
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
pause
