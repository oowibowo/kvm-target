#!/bin/bash

################################################
# VM Variables
# For ease of idfentification, replicate and 
# replace the last number with VGPU index
################################################

# VM1
VGPU1="f50aab10-7cc8-11e9-a94b-6b9d8245bfc1"
TPM1="tpm1"

# VM2
#VGPU2="f50aab10-7cc8-11e9-a94b-6b9d8245bfc2"
#TPM2="tpm2"

# VM3
#VGPU3="f50aab10-7cc8-11e9-a94b-6b9d8245bfc3"
#TPM3="tpm3"

################################################
# GVT Variables
################################################
MASK=0x0000000000000402
VGPU_TYPE="i915-GVTg_V5_4"
BASEVGPU="/sys/bus/pci/devices/0000:00:02.0"
VGPUS=" $VGPU1 $VGPU2 $VGPU3 "


################################################
# Directory Variables
################################################

# Choose from default or current directory
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
DEFAULT_DIR="/var/vm"
DIR=${DEFAULT_DIR}

# Other directories
TPM_DIR="${DIR}/tpm"
SCRIPTS_DIR="${DIR}/scripts"
DISK_DIR="${DIR}/disk"
