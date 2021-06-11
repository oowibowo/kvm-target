#!/bin/bash

################################################
# VM Variables
# For ease of idfentification, replicate and 
# replace the last number with VGPU index
################################################

# VM1
export IDV_VGPU1="f50aab10-7cc8-11e9-a94b-6b9d8245bfc1"
export IDV_TPM1="tpm1"

# VM2
#export IDV_VGPU2="f50aab10-7cc8-11e9-a94b-6b9d8245bfc2"
#export IDV_TPM2="tpm2"

# VM3
#export IDV_VGPU3="f50aab10-7cc8-11e9-a94b-6b9d8245bfc3"
#export IDV_TPM3="tpm3"

################################################
# GVT Variables
################################################
export IDV_MASK=0x0000000000000402
export IDV_VGPU_TYPE="i915-GVTg_V5_4"
export IDV_BASEVGPU="/sys/bus/pci/devices/0000:00:02.0"
export IDV_VGPUS=" $VGPU1 $VGPU2 $VGPU3 "

################################################
# Directory Variables
################################################

# IDV Directories
export IDV_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
export IDV_HOME=${IDV_SCRIPT/\/scripts/}
export IDV_TPM="${IDV_HOME}/tpm"
export IDV_DISK="${IDV_HOME}/disk"
