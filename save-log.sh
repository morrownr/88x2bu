#!/bin/bash
#
SCRIPT_NAME=save-log.sh
#
# Purpose: Save a log file with RTW lines only.
#
# To make this file executable:
#
# $ chmod +x save-log.sh
#
# To execute this file:
#
# $ sudo ./edit-options.sh
#
if [ $EUID -ne 0 ]
then
	echo "You must run ${SCRIPT_NAME} with superuser priviliges."
	echo "Try: \"sudo ./${SCRIPT_NAME}\""
	exit 1
fi

rm -f -- rtw.log

dmesg | sed 's/[^ ]* //' >> rtw.log
RESULT=$?

if [ "$RESULT" != "0" ]
then
	echo "An error occurred while running: ${SCRIPT_NAME}"
	exit 1
else
	echo "rtw.log saved successfully."
fi

exit 0
