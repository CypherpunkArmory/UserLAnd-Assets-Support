#! /bin/bash

SCRIPT_PATH=$(realpath ${BASH_SOURCE})
#sudo rm -f $SCRIPT_PATH

if [ ! -f /usr/games/frotz ]; then
   sudo apt-get install frotz
fi
if [ ! -f ~/adventure ]; then
   mkdir ~/adventure
fi
cd ~/adventure
if [ ! -f Advent.z5 ]; then
   wget http://mirror.ifarchive.org/if-archive/games/zcode/Advent.z5
fi
frotz Advent.z5
