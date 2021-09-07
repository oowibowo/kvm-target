#!/bin/bash

/usr/bin/qemu-system-x86_64 -enable-kvm -m 4096 -smp 2 -M pc -name Ubuntu-Guest -hda /var/vm/disk/ubuntu-desktop-1.qcow2 -snapshot -net nic,model=virtio,macaddr=00:DE:AD:BE:EF:F1 -net user -display egl-headless -k en-us -vnc :1 -machine kernel_irqchip=on -global PIIX4_PM.disable_s3=1 -global PIIX4_PM.disable_s4=1 -cpu host -usb -device usb-tablet -device vfio-pci,sysfsdev=/sys/bus/pci/devices/0000:00:02.0/f50aab10-7cc8-11e9-a94b-6b9d8245bfc1,rombar=0,display=on,x-igd-opregion=off

