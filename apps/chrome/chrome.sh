#! /bin/bash

SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

if [ ! -f /support/.chromium_app_install_passed ] || [ ! -f /usr/bin/chromium ]; then
   rm -f /support/.chromium_app_install_passed 
   sudo apt-get update
   sudo DEBIAN_FRONTEND=noninteractive apt-get -y install chromium-browser
   if [[ $? == 0 ]]; then
      touch /support/.chromium_app_install_passed
   else
      read -rsp $'An error occurred installing packages, please try again and if it persists provide this log to the developer.\nPress any key to close...\n' -n1 key
      exit
   fi
fi
/usr/bin/chromium --no-sandbox &> /dev/null &
