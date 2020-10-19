#!/bin/bash

DRV_NAME=rtl88x2bu
DRV_VERSION=5.8.7.4

if [[ $EUID -ne 0 ]]; then
  echo "You must run this installation script with superuser priviliges."
  echo "Try \"sudo ./dkms-remove.sh\""
  exit 1
fi

echo ""
echo "Removing /etc/modprobe.d/88x2bu.conf"
rm -f /etc/modprobe.d/88x2bu.conf

echo ""
echo "Removing /usr/src/${DRV_NAME}-${DRV_VERSION)"
rm -rf /usr/src/${DRV_NAME}-${DRV_VERSION}

dkms remove ${DRV_NAME}/${DRV_VERSION} --all
RESULT=$?

if [[ "$RESULT" != "0" ]]; then
  echo "An error occurred while running dkms remove"
  exit $RESULT
else
  echo "dkms-remove.sh was successful."
fi

