#!/bin/sh

set -eu

# Set the following sysctl values to optimize system performance
sysctl hw.snd.latency=7
sysctl hw.snd.maxautovchans=4
sysctl net.inet.tcp.sendbuf_max=16777216
sysctl net.inet.tcp.recvbuf_max=16777216
sysctl kern.ipc.maxsockbuf=16777216
sysctl kern.ipc.shmmax=67108864
sysctl kern.ipc.shmall=32768
sysctl kern.maxfiles=200000
sysctl kern.maxfilesperproc=200000
sysctl kern.geom.part.check_integrity=0

# Enable TRIM for SSDs
sysctl kern.geom.trim.enabled=1

# Disable debugging symbols
rm -rf /usr/lib/debug/*

# Disable kernel crash dumps
sysctl kern.corefile=/dev/null

# Reboot the system
shutdown -r now
