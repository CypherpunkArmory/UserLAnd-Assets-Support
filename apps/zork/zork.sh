#! /bin/bash

SCRIPT_PATH=$(realpath ${BASH_SOURCE})
#sudo rm -f $SCRIPT_PATH

if [ ! -f /usr/games/frotz ]; then
   sudo apt-get install frotz
fi
if [ ! -f ~/zork ]; then
   mkdir ~/zork
fi
cd ~/zork
if [ ! -f zdungeon.z5 ]; then
   wget http://mirror.ifarchive.org/if-archive/games/zcode/zdungeon.z5
fi
frotz zdungeon.z5
