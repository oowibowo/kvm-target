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

# Look for first argument
if [ $# -eq 0 ]; then
    echo "No argument supplied, please execute like this"
    echo "  ${CWDIR}/run-tpm.sh tpm1"
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
TPM_STATE=${TPM_DIR}/${TPM_NAME}
mkdir -p ${TPM_STATE}

# Execute command
CMDLINE="/usr/bin/swtpm socket -t \
         --tpmstate dir=${TPM_STATE} \
         --ctrl type=unixio,path=${TPM_STATE}/swtpm-sock \
         --tpm2 \
         --pid file=${TPM_PID}"

$CMDLINE
echo $CMDLINE

exit 0
