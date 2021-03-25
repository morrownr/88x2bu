#!/bin/bash
#
OPTIONS_FILE="88x2bu.conf"

SCRIPT_NAME="edit-options.sh"
#
# Purpose: Make it easier to edit the driver options file.
#
# To make this file executable:
#
# $ chmod +x edit-options.sh
#
# To execute this file:
#
# $ sudo ./edit-options.sh
#
if [[ $EUID -ne 0 ]]; then
	echo "You must run this script with superuser (root) privileges."
	echo "Try: \"sudo ./${SCRIPT_NAME}\""
	exit 1
fi

nano /etc/modprobe.d/${OPTIONS_FILE}

while true; do
    read -p "Do you want to active the new options by rebooting now?" yn
    case $yn in
        [Yy]* ) reboot; break;;
        [Nn]* ) exit 0;;
        * ) echo "Please answer Yes or No.";;
    esac
done
