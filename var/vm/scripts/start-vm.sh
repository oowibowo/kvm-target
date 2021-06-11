#!/bin/bash

################################################
# IMPORTANT 
# Specify VM Here

VGPU=${IDV_VGPU1}
TPM=${IDV_TPM1}

################################################

# Create TPM
${IDV_SCRIPT}/run-tpm.sh ${TPM}

# Run script
/usr/bin/qemu-system-x86_64 \
    -enable-kvm \
    -M q35 \
    -k en-us \
    -smp cores=2 \
    -m 2048 \
    -name ChromeOS-VM1 \
    -drive file=${IDV_DISK}/vm1-chromeos.qcow2 \
    -vga none \
    -nic user \
    -no-hpet \
    -bios /usr/share/qemu/OVMF.fd \
    -vnc :1 \
    -cpu host \
    -device vfio-pci,sysfsdev=${IDV_BASEVGPU}/${VGPU},display=on,x-igd-opregion=on,xres=1900,yres=1080 \
    -display egl-headless \
    -machine q35,accel=kvm,kernel_irqchip=on,vmport=off \
    -usb -device usb-tablet \
    -global ICH9-LPC.disable_s3=1 \
    -global ICH9-LPC.disable_s4=1 \
    -chardev socket,id=chrtpm,path=${IDV_TPM}/${TPM}/swtpm-sock \
    -tpmdev emulator,id=${TPM},chardev=chrtpm -device tpm-tis,tpmdev=${TPM} \
    -device intel-iommu,caching-mode=on,device-iotlb=off \
    -rtc base=localtime,clock=host

