#! /bin/bash

# Installation von Banking4 mit Wine
echo "Herunterladen vonwine-10.0-staging-amd64"

cd ~
wget https://github.com/Kron4ek/Wine-Builds/releases/download/10.0/wine-10.0-staging-amd64.tar.xz
tar -xvf  wine-10.0-staging-amd64.tar.xz
mv wine-10.0-staging-amd64 ~/.wine-10.0-staging-amd64
rm wine-10.0-staging-amd64.tar.xz

echo "Löschen von Wine-Mono"
rm ~/.cache/.wine/wine-mono-9.4.0-x86.msi

echo "Erzeugen der Wineprefix .Banking4 und Installation von Banking4"
echo "Achtung! Wine-Mono nicht installieren, wenn danach gefragt wird!"

wget "https://subsembly.com/download/TopBanking4ProSetup.exe"
WINEPREFIX=~/.Banking4-10.0 ~/.wine-10.0-staging-amd64/bin/wine ~/TopBanking4ProSetup.exe

rm TopBanking4ProSetup.exe
echo "Installation von dotnet40"

WINEPREFIX=~/.Banking4-10.0 ~/.wine-10.0-staging-amd64/bin/wine winecfg -v win7
wget 'http://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe'
WINEPREFIX=~/.Banking4-10.0 ~/.wine-10.0-staging-amd64/bin/wine ~/dotNetFx40_Full_x86_x64.exe /q
rm dotNetFx40_Full_x86_x64.exe

# Overriding mscoree.dll
WINEPREFIX=~/.Banking4-10.0 ~/.wine-10.0-staging-amd64/bin/wine reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v mscoree /t REG_SZ /d native

echo "Installation von dotnet48"
wget 'https://download.visualstudio.microsoft.com/download/pr/7afca223-55d2-470a-8edc-6a1739ae3252/abd170b4b0ec15ad0222a809b761a036/ndp48-x86-x64-allos-enu.exe'
WINEPREFIX=~/.Banking4-10.0 ~/.wine-10.0-staging-amd64/bin/wine ~/ndp48-x86-x64-allos-enu.exe /q
rm ndp48-x86-x64-allos-enu.exe

echo "Renderer=gdi"
WINEPREFIX=~/.Banking4-10.0 ~/.wine-10.0-staging-amd64/bin/wine reg add 'HKEY_CURRENT_USER\Software\Wine\Direct3D' /v renderer /t REG_SZ /d gdi /f

#Overriding websocket.dll
WINEPREFIX=~/.Banking4-10.0 ~/.wine-10.0-staging-amd64/bin/wine reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v websocket /t REG_SZ /d native

echo "Schriftart Tahoma wird installiert"
cd
wget "https://master.dl.sourceforge.net/project/corefonts/OldFiles/IELPKTH.CAB?viasf=1"
mkdir ~/tahoma
cabextract -d ~/tahoma/ IELPKTH.CAB?viasf=1
cd ~/tahoma/
sudo cp tahoma.ttf ~/.Banking4-10.0/drive_c/windows/Fonts/
sudo cp tahomabd.ttf ~/.Banking4-10.0/drive_c/windows/Fonts/
rm -rf ~/tahoma
rm -r ~/IELPKTH.CAB?viasf=1

WINEPREFIX=~/.Banking4-10.0 ~/.wine-10.0-staging-amd64/bin/wine reg add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Fonts' /v "Tahoma" /t REG_SZ /d "tahoma.ttf" /f 

WINEPREFIX=~/.Banking4-10.0 ~/.wine-10.0-staging-amd64/bin/wine reg add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Fonts' /v "Tahoma Bold" /t REG_SZ /d "tahomabd.ttf" /f
 
WINEPREFIX=~/.Banking4-10.0 ~/.wine-10.0-staging-amd64/bin/wine reg add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Fonts' /v "Tahoma" /t REG_SZ /d "tahoma.ttf" /f

WINEPREFIX=~/.Banking4-10.0 ~/.wine-10.0-staging-amd64/bin/wine reg add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Fonts' /v "Tahoma Bold" /t REG_SZ /d "tahomabd.ttf" /f

echo "Starten von Banking4"
cd 
WINEPREFIX=~/.Banking4-10.0 ~/.wine-10.0-staging-amd64/bin/wine ~/.Banking4-10.0/drive_c/"Program Files (x86)"/TopBanking4/TopBankingPro.exe

