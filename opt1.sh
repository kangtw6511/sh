#!/bin/sh

set -eu

# Set sysctl values for better network and disk performance
cat << EOF >> /etc/sysctl.conf
# Network optimization
net.inet.tcp.sendbuf_max=16777216
net.inet.tcp.recvbuf_max=16777216
net.inet.tcp.sendspace=262144
net.inet.tcp.recvspace=262144
net.inet.tcp.mssdflt=1440
net.inet.tcp.rfc1323=1
net.inet.tcp.delayed_ack=0
net.inet.tcp.slowstart_flightsize=30
net.inet.tcp.local_slowstart_flightsize=10
net.inet.tcp.blackhole=2
net.inet.udp.blackhole=1

# Disk optimization
vfs.read_max=32
vfs.write_max=32
vfs.max_bio=4096
vfs.max_physio=262144
kern.geom.part.check_integrity=0
kern.cam.scsi_delay=5000
kern.cam.scsi_timeout=60000
EOF

# Disable debugging symbols
rm -rf /usr/lib/debug/*

# Enable TRIM on SSDs
sysrc trim_enable="YES"

# Set power management settings for Intel CPUs
cat << EOF >> /etc/rc.conf
# Power management settings for Intel CPUs
powerdxx_enable="YES"
powerdxx_flags="-a adaptive -b adaptive -n adaptive -m 800 -M 1600 -r 50"
EOF

# Enable IPFW firewall with basic rules
sysrc firewall_enable="YES"
sysrc firewall_type="open"
sysrc firewall_logging="YES"
cat << EOF > /etc/ipfw.rules
#!/bin/sh
ipfw -q flush
ipfw add allow all from any to any via lo0
ipfw add deny all from 127.0.0.0/8 to any in
ipfw add allow tcp from any to any established
ipfw add allow udp from any to any established
ipfw add allow icmp from any to any
EOF
chmod +x /etc/ipfw.rules

# Enable IPFW NAT and forward rules (if applicable)
# sysrc gateway_enable="YES"
# sysrc pf_enable="YES"
# cat << EOF >> /etc/pf.conf
# # NAT rules
# nat on wlan0 from any to (wlan0) -> (wlan0)
# # Forward rules
# pass quick on $ext_if inet proto tcp to $web_server port $web_port \
#     rdr-to $web_server_local_ip port $web_port
# EOF

# Reboot the system
shutdown -r now
