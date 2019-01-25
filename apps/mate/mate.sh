#! /bin/bash

SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

if [ ! -f /usr/bin/user/bin/user/bin/mate ]; then
   sudo apt-get update
   sudo DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install mate-desktop-environment
fi

if [[ $? != 0 ]]; then
   read -rsp $'An error occurred installing packages, please try again and if it persists provide this log to the developer.\nPress any key to close...\n' -n1 key
   exit
fi

mate-session

exit
