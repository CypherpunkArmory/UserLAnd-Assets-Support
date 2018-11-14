#! /bin/bash

SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

if [ ! -f /usr/bin/libreoffice ]; then
	echo "Warning: LibreOffice is a fairly large package"
	echo "with many dependencies. Please ensure you have"
	echo "the appropriate drive space before installing."
	sleep 5
	sudo apt-get update
	sudo DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install libreoffice

fi

if [[ $? != 0 ]]; then
   read -rsp $'An error occurred installing packages, please try again and if it persists provide this log to the developer.\nPress any key to close...\n' -n1 key
   exit
fi

libreoffice

exit
