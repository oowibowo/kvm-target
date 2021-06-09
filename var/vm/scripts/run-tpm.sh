#!/bin/bash
set -x

# Look and source env config
ENVCONFIG="/var/vm/scripts/env.sh"
if [ ! -f $ENVCONFIG ]; then
    echo "Could not find necessary environment setting."
    exit 1
fi
source $ENVCONFIG

# Exit if no extra arguments
if [ $# -eq 0 ]; then
    echo "No argument supplied, please pass the tpm subfolder under /var/vm/tpm"
    exit 1
fi

# Check for swtpm command
if ! command -v swtpm &> /dev/null; then
    add-apt-repository ppa:stefanberger/swtpm-focal
    add-apt-repository -y ppa:stefanberger/swtpm-focal
fi

# check if tpm folder/files exists
TPM_NAME=${1}
TPM_FILE="/tmp/${TPM_NAME}.pid"
TPM_DIR=$TPM_BASEDIR/${1}
TPM_SOCK=${TPM_DIR}/swtpm-sock
mkdir -p $TPM_DIR

if [ -f ${TPM_FILE} ]; then 
    echo "Exiting: ${TPM_FILE} already exists"
    exit 1
fi

# Execute command
CMDLINE="/usr/bin/swtpm socket -t \
         --tpmstate dir=${TPM_DIR} \
         --ctrl type=unixio,path=${TPM_SOCK} \
         --tpm2 \
         --pid file=${TPM_FILE}"
$CMDLINE
echo $CMDLINE

exit 0
