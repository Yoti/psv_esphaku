@echo off
cd data

if exist go rd /q /s go
mkdir go
cd go
	wget -q --show-progress -O index.html http://vitawiki.xyz/go/exploit.html
	wget -q --show-progress http://vitawiki.xyz/go/henkaku.bin
	wget -q --show-progress http://vitawiki.xyz/go/payload.js
	wget -q --show-progress http://vitawiki.xyz/go/pkg/henkaku.skprx
	wget -q --show-progress http://vitawiki.xyz/go/pkg/henkaku.suprx
	wget -q --show-progress http://vitawiki.xyz/go/pkg/taihen.skprx
cd ..

if exist henlo rd /q /s henlo
mkdir henlo
cd henlo
	wget -q --show-progress http://vitawiki.xyz/henlo/exploit.js
	wget -q --show-progress http://vitawiki.xyz/henlo/index.html
	wget -q --show-progress http://vitawiki.xyz/henlo/jsos.js
	wget -q --show-progress http://vitawiki.xyz/henlo/kernel.js
	wget -q --show-progress http://vitawiki.xyz/henlo/offsets.js
	wget -q --show-progress http://vitawiki.xyz/henlo/payload.bin
cd ..

if exist release rd /q /s release
mkdir release
cd release
	wget -q --show-progress http://vitawiki.xyz/go/pkg/sce_sys/livearea/contents/install_button.png
	wget -q --show-progress http://vitawiki.xyz/release/bg.png
	wget -q --show-progress http://vitawiki.xyz/release/eboot.bin
	wget -q --show-progress http://vitawiki.xyz/release/head.bin
	wget -q --show-progress http://vitawiki.xyz/release/icon0.png
	wget -q --show-progress http://vitawiki.xyz/release/param.sfo
	wget -q --show-progress http://vitawiki.xyz/release/startup.png
	wget -q --show-progress http://vitawiki.xyz/release/template.xml
cd ..

pause
