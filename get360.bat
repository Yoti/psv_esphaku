@echo off

cd data
if exist 360 rd /q /s 360
mkdir 360
cd 360

wget -q --show-progress http://henkaku.xyz/go/index.html
wget -q --show-progress http://henkaku.xyz/go/payload.js
wget -q --show-progress http://henkaku.xyz/go/henkaku.bin

wget -q --show-progress http://henkaku.xyz/go/pkg/eboot.bin
wget -q --show-progress http://henkaku.xyz/go/pkg/sce_sys/param.sfo
wget -q --show-progress http://henkaku.xyz/go/pkg/sce_sys/icon0.png
wget -q --show-progress http://henkaku.xyz/go/pkg/sce_sys/package/head.bin
wget -q --show-progress http://henkaku.xyz/go/pkg/sce_sys/livearea/contents/bg.png
wget -q --show-progress http://henkaku.xyz/go/pkg/sce_sys/livearea/contents/install_button.png
wget -q --show-progress http://henkaku.xyz/go/pkg/sce_sys/livearea/contents/startup.png
wget -q --show-progress http://henkaku.xyz/go/pkg/sce_sys/livearea/contents/template.xml

wget -q --show-progress http://henkaku.xyz/go/pkg/taihen.skprx
wget -q --show-progress http://henkaku.xyz/go/pkg/henkaku.skprx
wget -q --show-progress http://henkaku.xyz/go/pkg/henkaku.suprx

pause