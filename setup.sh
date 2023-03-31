#!/bin/sh

freebsd-update fetch
freebsd-update install
reboot

pkg bootstrap
pkg update

pkg ins sudo nano drm-kmod

nano /etc/rc.conf
kld_list="i915kms"

pw groupmod video -m kang

pkg ins xorg firefox noto-kr


# Change locale to Korean
echo 'ko_KR.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
echo 'LANG=ko_KR.UTF-8' > /etc/locale.conf

# Update package repository and upgrade installed packages
pkg update -f
pkg upgrade -y

# Install necessary packages for Korean locale and input
pkg install -y lightdm-gtk-greeter xfce xfce4-goodies dbus fcitx5-gtk fcitx5-configtool ko-fcitx5-hangul wifimgr

# Configure sudo access for wheel group
sed -i '' 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /usr/local/etc/sudoers

# Configure boot settings
sysrc autoboot_delay="2"
sysrc background_dhclient="YES"
sysrc kld_list+="i915kms"

# Configure network settings
sysrc wlans_iwn0="wlan0"
sysrc ifconfig_wlan0="WPA SYNCDHCP"

# Add user to wheel and video groups
pw groupmod wheel -m kang
pw groupmod video -m kang

# Set audio settings
mixer mic 50:50
mixer vol 95:95

# Enable LightDM and D-Bus message bus at boot time
sysrc lightdm_enable="YES"
sysrc dbus_enable="YES"

# Configure fcitx5-hangul
sysrc fcitx_enable="YES"
sysrc fcitx_program_variable="FCITX5"
sysrc fcitx_flags="-d"
echo 'export GTK_IM_MODULE=fcitx' >> /etc/profile
echo 'export QT_IM_MODULE=fcitx' >> /etc/profile
echo 'export XMODIFIERS="@im=fcitx"' >> /etc/profile

# Configure virtual terminal type
sysrc kern.vty="vt"

# Add /proc filesystem to /etc/fstab
echo 'proc /proc procfs rw 0 0' >> /etc/fstab

# Mount root file system as read-write
mount -u -w /

# Reboot the system
shutdown -r now
