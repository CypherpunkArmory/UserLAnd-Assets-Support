#! /bin/bash

SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

if [ ! -f /usr/bin/startxfce4 ]; then
   sudo apt-get update
   sudo DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install xfce4
   if [[ $? != 0 ]]; then
      read -rsp $'An error occurred installing packages, please try again and if it persists provide this log to the developer.\nPress any key to close...\n' -n1 key
      exit
   fi
fi

if grep -q "user-session=xfce" /usr/share/lightdm/lightdm.conf.d/userland.conf; then
   echo "already setup"
else
   sudo echo "[SeatDefaults]" > /usr/share/lightdm/lightdm.conf.d/userland.conf
   sudo echo "user-session=xfce" >> /usr/share/lightdm/lightdm.conf.d/userland.conf
   while true
   do
	   RED='\033[0;31m'
	   BLUE='\033[0;34m'
	   echo -e "${BLUE}You are requesting a new desktop environment a restart is required."
	   echo -e "${RED}Stop and then restart the app in UserLAnd."
	   sleep 5
   done
fi

exit
