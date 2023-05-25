#! /bin/bash

SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

if [ ! -f /usr/bin/code-server ]; then
    sudo apt update
    sudo apt install -y ca-certificates
    sudo curl -fsSL https://code-server.dev/install.sh | sh
fi

if [[ $? != 0 ]]; then
   read -rsp $'An error occurred installing packages, please try again and if it persists provide this log to the developer.\nPress any key to close...\n' -n1 key
   exit
fi

code-server

exit
