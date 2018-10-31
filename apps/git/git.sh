#! /bin/bash

SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

if [ ! -f /usr/bin/git]; then
	rm -rf /usr/bin/git
	sudo apt-get update && sudo apt-get upgrade

	sudo DEBIAN_FRONTEND=noninteractive apt-get -y install git-core

	   if [[ $? == 0 ]]; then
		   /usr/bin/git

	   else 
		   echo "error during install, closing"
		   exit

	   fi

   fi
   exit


