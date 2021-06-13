#!/bin/bash

#set -x
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run by superuser."
    exit 1
fi

# Setting VGPU mask
#/bin/sh -c "echo $IDV_MASK > /sys/class/drm/card0/gvt_disp_ports_mask"
# iterate through vgpu uuid and create uuid
for uuid in $IDV_VGPU1 $IDV_VGPU2 $IDV_VGPU3; do
    #echo $uuid
    if [ ! -d ${IDV_BASEVGPU}/${uuid} ]; then
        /bin/sh -c "echo $uuid > ${IDV_BASEVGPU}/mdev_supported_types/${IDV_VGPU_TYPE}/create"
    else
        echo "${IDV_BASEVGPU}/${uuid} already exists"
    fi
done

