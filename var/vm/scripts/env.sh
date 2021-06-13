#!/bin/bash

################################################
# VM Variables
# For ease of idfentification, replicate and 
# replace the last number with VGPU index
################################################

# VM1
IDV_VGPU1="f50aab10-7cc8-11e9-a94b-6b9d8245bfc1"
IDV_TPM1="tpm1"
IDV_VM1="1"
export IDV_VGPU1
export IDV_TPM1
export IDV_VM1

# VM2
IDV_VGPU2="f50aab10-7cc8-11e9-a94b-6b9d8245bfc2"
IDV_TPM2="tpm2"
IDV_VM2="2"
export IDV_VGPU2
export IDV_TPM2
export IDV_VM2

# VM3
#IDV_VGPU3="f50aab10-7cc8-11e9-a94b-6b9d8245bfc3"
#IDV_TPM3="tpm3"
#IDV_VM3="3"

################################################
# GVT Variables
################################################
IDV_MASK=0x0000000000000402
IDV_VGPU_TYPE="i915-GVTg_V5_4"
IDV_BASEVGPU="/sys/bus/pci/devices/0000:00:02.0"
export IDV_MASK
export IDV_VGPU_TYPE
export IDV_BASEVGPU

################################################
# Directory Variables
################################################

# IDV Directories
IDV_HOME=/var/vm
IDV_TPM=/var/vm/tpm
IDV_DISK=/var/vm/disk
IDV_SCRIPT=/var/vm/scripts
export IDV_SCRIPT
export IDV_HOME
export IDV_TPM
export IDV_DISK
