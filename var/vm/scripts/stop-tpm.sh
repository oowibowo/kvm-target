#!/bin/bash

# Look for first argument
if [ $# -eq 0 ]; then
    echo "No argument supplied, please execute like this"
    echo "  ${IDV_SCRIPT}/stop-tpm.sh tpm1"
    exit 1
fi

TPM_NAME=${1}

PIDFILE="/tmp/${TPM_NAME}.pid"

#Check for existing pid
if [ ! -f "$PIDFILE" ]; then
    echo "PID file $PIDFILE does not exist. Nothing to do"
    exit 0;
fi

PIDNUM=`cat $PIDFILE`
PCMDL="/proc/${PIDNUM}/cmdline"
ISSWTPM=`grep swtpm ${PCMDL}`
echo "PID is $PIDNUM"

#Kill if swtpm process
if [ ! -z "$ISSWTPM" ]; then
    echo "Killing process PIDNUM: ${PIDNUM}" 
    kill -9 ${PIDNUM}
fi

#Stale file for PID that doesn't exist
if [ -f "$PIDFILE" ]; then
    echo "Removing PIDFILE: ${PIDFILE}"
    rm -f ${PIDFILE}
fi

TPM_STATE=${IDV_TPM}/${TPM_NAME}
rm -rf ${TPM_STATE}

exit 0
