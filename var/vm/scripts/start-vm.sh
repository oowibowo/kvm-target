#!/bin/bash

/usr/bin/qemu-system-x86_64 \
    -enable-kvm \
    -M q35 \
    -k en-us \
    -smp cores=2 \
    -m 2048 \
    -name ChromeOS-VM1 \
    -drive file=/var/vm/disk/vm1-chromeos.qcow2 \
    -vga none \
    -nic user \
    -no-hpet \
    -bios /usr/share/qemu/OVMF.fd \
    -vnc :1 \
    -cpu host \
    -device vfio-pci,sysfsdev=/sys/bus/pci/devices/0000:00:02.0/f50aab10-7cc8-11e9-a94b-6b9d8245bfc1,display=on,x-igd-opregion=on,xres=1900,yres=1080 \
    -display egl-headless \
    -machine q35,accel=kvm,kernel_irqchip=on,vmport=off \
    -usb -device usb-tablet \
    -global ICH9-LPC.disable_s3=1 \
    -global ICH9-LPC.disable_s4=1 \
    -device intel-iommu,caching-mode=on,device-iotlb=off \
    -rtc base=localtime,clock=host

