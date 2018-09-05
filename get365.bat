@echo off

cd data
rd /q /s 365
mkdir 365
cd 365

wget -q --show-progress http://henkaku.xyz/go/index.html

pause