#!/bin/bash

# Look for first argument
if [ $# -eq 0 ]; then
    echo "No argument supplied, please execute like this"
    echo "  ${IDV_SCRIPT}/run-tpm.sh tpm1"
    exit 1
fi

TPM_NAME=${1}

# Check for swtpm command
if ! command -v swtpm &> /dev/null; then
    add-apt-repository -y ppa:stefanberger/swtpm-focal
    apt-get update -y
    apt-get install -y swtpm
fi

# check if tpm already exists using pid
TPM_PID="/tmp/${TPM_NAME}.pid"
if [ -f ${TPM_PID} ]; then 
    echo "Exiting: ${TPM_PID} already exists"
    exit 1
fi

# TPM folder
TPM_STATE=${IDV_TPM}/${TPM_NAME}
mkdir -p ${TPM_STATE}

# Execute command
CMDLINE="/usr/bin/swtpm socket -t \
         --tpmstate dir=${TPM_STATE} \
         --ctrl type=unixio,path=${TPM_STATE}/swtpm-sock \
         --tpm2 \
         --pid file=${TPM_PID}"

$CMDLINE &
echo $CMDLINE

exit 0
