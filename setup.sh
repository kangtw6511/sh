#!/bin/sh

# Update FreeBSD system
freebsd-update fetch install
pkg update -f
pkg upgrade -y

# Install necessary packages
pkg install -y sudo nano xorg firefox noto-fonts lightdm-gtk-greeter xfce xfce4-goodies dbus fcitx5-gtk fcitx5-configtool ko-fcitx5-hangul wifimgr

# Configure system settings
echo 'kern.vty=vt' >> /boot/loader.conf
sysrc -f /etc/rc.conf kld_list+="i915kms"
sysrc -f /etc/rc.conf background_dhclient="YES"
sysrc -f /etc/rc.conf lightdm_enable="YES"
sysrc -f /etc/rc.conf dbus_enable="YES"
sysrc -f /etc/rc.conf fcitx_enable="YES"
sysrc -f /etc/rc.conf fcitx_program_variable="FCITX5"
sysrc -f /etc/rc.conf fcitx_flags="-d"

# Configure sudo access for the wheel group
sed -i '' 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /usr/local/etc/sudoers

# Add user to wheel and video groups
pw groupmod wheel -m kang
pw groupmod video -m kang

# Configure network settings
sysrc -f /etc/rc.conf wlans_iwm0="wlan0"
sysrc -f /etc/rc.conf ifconfig_wlan0="WPA DHCP"

# Set audio settings
mixer vol 95:95
mixer mic 50:50

# Configure input method
echo 'export GTK_IM_MODULE=fcitx5' >> /etc/profile
echo 'export QT_IM_MODULE=fcitx5' >> /etc/profile
echo 'export XMODIFIERS="@im=fcitx5"' >> /etc/profile

# Configure locale
echo 'ko_KR.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
echo 'LANG=ko_KR.UTF-8' > /etc/locale.conf

# Add /proc filesystem to /etc/fstab
echo 'proc /proc procfs rw 0 0' >> /etc/fstab

# Reboot the system
reboot
