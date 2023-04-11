#!/bin/bash

# Arch Linux GNOME 경량화 및 개선 스크립트
# root 권한으로 실행해 주세요.

# 패키지 업데이트
pacman -Syu --noconfirm

# GNOME 설치
pacman -S --noconfirm gnome gnome-tweaks gnome-control-center

# 불필요한 패키지 삭제
pacman -Rs --noconfirm gnome-photos gnome-music gnome-weather gnome-contacts gnome-documents gnome-boxes totem

# 불필요한 서비스 중지
systemctl disable --now bluetooth.service cups.service

# SWAP 비활성화
swapoff -a && sed -i '/swap/s/^/#/' /etc/fstab

# 불필요한 토글 키 해제
gsettings set org.gnome.desktop.wm.preferences button-layout 'close:'

# 터미널 폰트 설정
pacman -S --noconfirm noto-fonts-cjk
gsettings set org.gnome.desktop.interface monospace-font-name 'Noto Sans Mono CJK KR Regular 10'

# 한글 입력기 설치 및 설정
pacman -S --noconfirm ibus ibus-hangul
gsettings set org.gnome.desktop.input-sources sources "[('ibus', 'hangul')]"
gsettings set org.gnome.desktop.input-sources xkb-options "['korean:ralt_hangul', 'korean:rctrl_hanja']"

# GNOME 확장 설치 및 비활성화
pacman -S --noconfirm gnome-shell-extension-dash-to-dock gnome-shell-extension-appindicator gnome-shell-extension-topicons-plus
for extension in appindicatorsupport@rgcjonas.gmail.com caffeine@patapon.info dash-to-dock@micxgx.gmail.com desktop-icons@csoriano gsconnect@andyholmes.github.io unimatrix@martin.sucha.cz; do
  gnome-extensions disable "$extension"
done

# GNOME 테마 설정
pacman -S --noconfirm gnome-shell-theme-adwaita

# GNOME 시작 프로그램 설정
mkdir -p ~/.config/autostart
cp /usr/share/applications/org.gnome.SettingsDaemon.Keyboard.desktop ~/.config/autostart/

# 스피커 볼륨 100% 설정
amixer -q sset Master 100%

# 불필요한 로그 삭제
journalctl --vacuum-size=50M

# 사용자 계정에 GNOME 추가
usermod -aG video,audio,input "$USER"

# 재부팅
reboot
