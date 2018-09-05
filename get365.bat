@echo off

cd data
if exist 365 rd /q /s 365
mkdir 365
cd 365

wget -q --show-progress --no-check-certificate http://rawgit.com/TheOfficialFloW/VitaShell/master/release/bg.png
wget -q --show-progress --no-check-certificate http://rawgit.com/TheOfficialFloW/VitaShell/master/release/eboot.bin
wget -q --show-progress --no-check-certificate http://rawgit.com/TheOfficialFloW/VitaShell/master/release/head.bin
wget -q --show-progress --no-check-certificate http://rawgit.com/TheOfficialFloW/VitaShell/master/release/icon0.png
wget -q --show-progress --no-check-certificate http://rawgit.com/TheOfficialFloW/VitaShell/master/release/param.sfo
wget -q --show-progress --no-check-certificate http://rawgit.com/TheOfficialFloW/VitaShell/master/release/startup.png
wget -q --show-progress --no-check-certificate http://rawgit.com/TheOfficialFloW/VitaShell/master/release/template.xml

pause