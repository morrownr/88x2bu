#!/bin/bash

DRV_NAME=rtl88x2bu
DRV_VERSION=5.8.7.4
KERNEL_VERSION=$(uname -r)
OPTIONS_FILE=88x2bu.conf
SCRIPT_NAME=remove-driver.sh

if [[ $EUID -ne 0 ]]; then
	echo "You must run this removal script with root privileges."
	echo "Try \"sudo ./${SCRIPT_NAME}\""
	exit 1
fi

dkms remove -m ${DRV_NAME} -v ${DRV_VERSION} -k ${KERNEL_VERSION}
RESULT=$?

if [[ "$RESULT" != "0" ]]; then
	echo "An error occurred while running: dkms remove -m ${DRV_NAME} -v ${DRV_VERSION} -k ${KERNEL_VERSION}"
	exit $RESULT
else
	rm -f /etc/modprobe.d/${OPTIONS_FILE}
	rm -rf /usr/src/${DRV_NAME}-${DRV_VERSION}-${KERNEL_VERSION}
	echo "The module has been removed successfully."
fi
