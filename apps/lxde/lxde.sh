#! /bin/bash

SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

if [ ! -f /usr/bin/startlxde ]; then
   sudo apt-get update
   sudo DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install lxde-core
   if [[ $? != 0 ]]; then
      read -rsp $'An error occurred installing packages, please try again and if it persists provide this log to the developer.\nPress any key to close...\n' -n1 key
      exit
   fi
fi 

if grep -q "Session=LXDE" ~/.dmrc; then
   echo "already setup"
else
   echo "[Desktop]" > ~/.dmrc
   echo "Session=LXDE" >> ~/.dmrc
   while true
	   RED='\033[0;31m'
	   BLUE='\033[0;34m'
	   echo -e "${BLUE}You are requesting a new desktop environment a restart is required."
	   echo -e "${RED}Stop and then restart the app in UserLAnd."
	   sleep 5
   do
   done
fi

exit
