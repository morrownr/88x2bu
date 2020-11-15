#!/bin/bash
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
if [ $EUID -ne 0 ]
then
	echo "You must run edit-options.sh with superuser priviliges."
	echo "Try: \"sudo ./edit-options.sh\""
	exit 1
fi

nano /etc/modprobe.d/88x2bu.conf
