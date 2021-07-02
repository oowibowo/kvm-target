#!/bin/bash

################################################
# IMPORTANT 
# Specify VM Here

VGPU=${IDV_VGPU2}
TPM=${IDV_TPM2}
VMNUM=${IDV_VM2}

################################################

# Destroy TPM
${IDV_SCRIPT}/stop-tpm.sh ${TPM}

PIDFILE="/tmp/qemu_${VMNUM}.pid"

#Check for existing pid
if [ ! -f "$PIDFILE" ]; then
	echo "PID file $PIDFILE does not exist. Nothing to do"
	exit 0;
fi

PIDNUM=`cat $PIDFILE`
PCMDL="/proc/${PIDNUM}/cmdline"
ISQEMU=`grep qemu-system-x86_64 ${PCMDL}`
echo "PID is $PIDNUM"

#Kill if qemu process
if [ ! -z "$ISQEMU" ]; then
	echo "Killing process PIDNUM: ${PIDNUM}"
    kill -9 ${PIDNUM}
fi

#Stale file for PID that doesn't exist
if [ -f "$PIDFILE" ]; then
	echo "Removing PIDFILE: ${PIDFILE}"
	rm -f ${PIDFILE}
fi

exit 0
