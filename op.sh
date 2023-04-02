#!/bin/sh

# Set the following sysctl values to optimize network performance
sysctl net.inet.tcp.mssdflt=1460
sysctl net.inet.tcp.sendbuf_max=16777216
sysctl net.inet.tcp.recvbuf_max=16777216
sysctl net.inet.tcp.sendbuf_inc=8192
sysctl net.inet.tcp.recvbuf_inc=32768
sysctl net.inet.tcp.delayed_ack=0
sysctl net.inet.tcp.slowstart_flightsize=40
sysctl net.inet.tcp.local_slowstart_flightsize=40
sysctl net.inet.tcp.tso=0

# Set the following sysctl values to optimize ZFS performance
sysctl vfs.zfs.arc_min=536870912
sysctl vfs.zfs.arc_max=1073741824
sysctl vfs.zfs.vdev.cache.size=33554432
sysctl vfs.zfs.vdev.cache.max=67108864
sysctl vfs.zfs.vdev.cache.bshift=17
sysctl vfs.zfs.prefetch_disable=1
sysctl vfs.zfs.txg.timeout=5
sysctl vfs.zfs.resilver_delay=1

# Set the following sysctl values to optimize virtual memory performance
sysctl vm.pmap.pg_ps_enabled=1
sysctl vm.pmap.pg_ps_max=2048
sysctl vm.pmap.pg_ps_partial=128
sysctl vm.pmap.pg_ps_limit=512
sysctl vm.pmap.pg_ps_rate=100

# Set the following sysctl values to optimize CPU performance
sysctl kern.sched.preempt_thresh=224
sysctl kern.sched.balance_interval=250000
sysctl kern.sched.slice=1
sysctl kern.sched.steal_thresh=2
sysctl kern.sched.preemption=1

# Set the following sysctl values to optimize memory performance
sysctl vm.vmtotal.anonmin=32768
sysctl vm.vmtotal.anonmax=262144
sysctl vm.vmtotal.vmtune=1

# Set the following sysctl values to optimize I/O performance
sysctl kern.cam.scsi.spc.sense_error=0
sysctl kern.cam.scsi.spc.disable_synch=1
sysctl kern.cam.scsi.max_dev_high=64
sysctl kern.cam.scsi.max_dev_low=16
sysctl kern.cam.scsi.max_lun=64
sysctl kern.cam.scsi.disk.write_cache=1
sysctl kern.cam.scsi.delay=0
sysctl kern.cam.scsi.maxcount=128
sysctl kern.cam.scsi.maxtags=32
sysctl kern.cam.scsi.tag_burst_limit=30

# Set the following sysctl values to optimize file system performance
sysctl kern.maxfiles=200000
sysctl kern.maxfilesperproc=100000

# Set the following sysctl values to optimize TCP/IP network performance
sysctl net.inet.tcp.inflight.enable=1
sysctl net.inet.tcp.inflight.debug=0
sysctl net.inet.tcp.inflight.max=1073741824
sysctl net.inet.tcp.inflight.min=524288
sysctl net.inet.tcp.inflight.stab=64
sysctl net.inet.tcp.inflight.start=1048576

# Reboot the system
shutdown -r now
