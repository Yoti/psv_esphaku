@echo off

cd data
if exist go rd /q /s go
mkdir go
cd go

wget -q --show-progress http://henkaku.xyz/go/index.html
wget -q --show-progress http://henkaku.xyz/go/payload.js
wget -q --show-progress http://henkaku.xyz/go/henkaku.bin

wget -q --show-progress http://raw.githubusercontent.com/TheOfficialFloW/VitaShell/master/release/eboot.bin
wget -q --show-progress http://raw.githubusercontent.com/TheOfficialFloW/VitaShell/master/release/param.sfo
wget -q --show-progress http://raw.githubusercontent.com/TheOfficialFloW/VitaShell/master/release/icon0.png
wget -q --show-progress http://raw.githubusercontent.com/TheOfficialFloW/VitaShell/master/release/head.bin
wget -q --show-progress http://raw.githubusercontent.com/TheOfficialFloW/VitaShell/master/release/bg.png
wget -q --show-progress http://henkaku.xyz/go/pkg/sce_sys/livearea/contents/install_button.png
wget -q --show-progress http://raw.githubusercontent.com/TheOfficialFloW/VitaShell/master/release/startup.png
wget -q --show-progress http://raw.githubusercontent.com/TheOfficialFloW/VitaShell/master/release/template.xml

wget -q --show-progress http://henkaku.xyz/go/pkg/taihen.skprx
wget -q --show-progress http://henkaku.xyz/go/pkg/henkaku.skprx
wget -q --show-progress http://henkaku.xyz/go/pkg/henkaku.suprx

pause
