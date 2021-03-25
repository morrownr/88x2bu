#!/bin/bash

DRV_NAME="rtl88x2bu"
DRV_VERSION="5.8.7.4"
OPTIONS_FILE="88x2bu.conf"

DRV_DIR="$(pwd)"
KRNL_VERSION="$(uname -r)"
SCRIPT_NAME="install-driver.sh"
SCRIPT_VERSION="20210325"

clear
echo "Version ${SCRIPT_VERSION}"

if [[ $EUID -ne 0 ]]; then
	echo "You must run this script with superuser (root) privileges."
	echo "Try: \"sudo ./${SCRIPT_NAME}\""
	exit 1
fi

if [[ -d "/usr/lib/dkms" ]]; then
	echo "Installing ${DRV_NAME}-${DRV_VERSION}"
else
	echo "dkms does not appear to be installed."
	echo "Please install dkms and try again."
	exit 1
fi

# Clean existing installation before starting. Yes, users have been trying
# to install over previous installations.
echo "Pre-installation checks in progress"
dkms remove ${DRV_NAME}/${DRV_VERSION}
rm -f /etc/modprobe.d/${OPTIONS_FILE}
rm -rf /usr/src/${DRV_NAME}-${DRV_VERSION}
echo "Pre-installation checks complete"

echo "Begin installation"
echo "Copying source files to: /usr/src/${DRV_NAME}-${DRV_VERSION}"
cp -r "${DRV_DIR}" /usr/src/${DRV_NAME}-${DRV_VERSION}
echo "Copying ${OPTIONS_FILE} to: /etc/modprobe.d"
cp -r ${OPTIONS_FILE} /etc/modprobe.d
echo "All required files have been copied to the proper places."

echo "dkms is now in charge of the installation."
dkms add ${DRV_NAME}/${DRV_VERSION}
RESULT=$?

if [[ "$RESULT" != "0" ]]; then
	echo "An error occurred while running: dkms add : ${RESULT}"
	dkms remove ${DRV_NAME}/${DRV_VERSION}
	echo "Removing ${OPTIONS_FILE} from: /etc/modprobe.d"
	rm -f /etc/modprobe.d/${OPTIONS_FILE}
	echo "Removing source files from: /usr/src/${DRV_NAME}-${DRV_VERSION}"
	rm -rf /usr/src/${DRV_NAME}-${DRV_VERSION}
	echo "The driver was not installed due to an error."
	echo "Please report errors."
	exit $RESULT
fi

dkms build ${DRV_NAME}/${DRV_VERSION}
RESULT=$?

if [[ "$RESULT" != "0" ]]; then
	echo "An error occurred while running: dkms build : ${RESULT}"
	dkms remove ${DRV_NAME}/${DRV_VERSION}
	echo "Removing ${OPTIONS_FILE} from: /etc/modprobe.d"
	rm -f /etc/modprobe.d/${OPTIONS_FILE}
	echo "Removing source files from: /usr/src/${DRV_NAME}-${DRV_VERSION}"
	rm -rf /usr/src/${DRV_NAME}-${DRV_VERSION}
	echo "The driver was not installed due to an error."
	echo "Please report errors."
	exit $RESULT
fi

dkms install ${DRV_NAME}/${DRV_VERSION}
RESULT=$?

if [[ "$RESULT" != "0" ]]; then
	echo "An error occurred while running: dkms install : ${RESULT}"
	dkms remove ${DRV_NAME}/${DRV_VERSION}
	echo "Removing ${OPTIONS_FILE} from: /etc/modprobe.d"
	rm -f /etc/modprobe.d/${OPTIONS_FILE}
	echo "Removing source files from: /usr/src/${DRV_NAME}-${DRV_VERSION}"
	rm -rf /usr/src/${DRV_NAME}-${DRV_VERSION}
	echo "The driver was not installed due to an error."
	echo "Please report errors."
	exit $RESULT
fi

echo "The driver was installed successfully."

read -p "Do you want edit the driver options file now (y/n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    nano /etc/modprobe.d/${OPTIONS_FILE}
fi

read -p "Are you ready to reboot now (y/n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    reboot
fi

exit 0
