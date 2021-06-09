#!/bin/bash

# Look in current and default directory scripts for env.sh file
CWDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
DEF_DIR="/var/vm/scripts"
ENV="env.sh"

# Try to source file
if [ -f ${CWDIR}/${ENV} ]; then
    ENVCONFIG="${CWDIR}/${ENV}"
elif [ -f ${SCRIPTSDIR}/${ENV} ]; then
    ENVCONFIG="${SCRIPTSDIR}/${ENV}"
else
    echo "No ${ENV} file found"
    exit 1
fi
    
echo "Using ${ENVCONFIG} file"
source ${ENVCONFIG}

################################################
# IMPORTANT 
# Specify VM Here
################################################
VGPU=${VGPU1}
TPM=${TPM1}

# Create TPM
${SCRIPTS_DIR}/run-tpm.sh ${TPM}

# Run script
/usr/bin/qemu-system-x86_64 \
    -enable-kvm \
    -M q35 \
    -k en-us \
    -smp cores=2 \
    -m 2048 \
    -name ChromeOS-VM1 \
    -drive file=${DISK_DIR}/vm1-chromeos.qcow2 \
    -vga none \
    -nic user \
    -no-hpet \
    -bios /usr/share/qemu/OVMF.fd \
    -vnc :1 \
    -cpu host \
    -device vfio-pci,sysfsdev=${BASEVGPU}/${VGPU},display=on,x-igd-opregion=on,xres=1900,yres=1080 \
    -display egl-headless \
    -machine q35,accel=kvm,kernel_irqchip=on,vmport=off \
    -usb -device usb-tablet \
    -global ICH9-LPC.disable_s3=1 \
    -global ICH9-LPC.disable_s4=1 \
    -chardev socket,id=chrtpm,path=${TPM_DIR}/${TPM}/swtpm-sock \
    -tpmdev emulator,id=${TPM},chardev=chrtpm -device tpm-tis,tpmdev=${TPM} \
    -device intel-iommu,caching-mode=on,device-iotlb=off \
    -rtc base=localtime,clock=host

