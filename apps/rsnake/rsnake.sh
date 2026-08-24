#! /bin/bash

SCRIPT_PATH=$(realpath "${BASH_SOURCE[0]}")
sudo rm -f "$SCRIPT_PATH"

if [ ! -x "$HOME/.cargo/bin/rsnake" ]; then
   sudo apt-get update
   sudo DEBIAN_FRONTEND=noninteractive apt-get -y install curl build-essential pkg-config ca-certificates
   if [ $? -ne 0 ]; then
      read -rsp $'Unable to install the build prerequisites. Please try again and, if the problem persists, provide this log to the developer.\nPress any key to close...\n' -n1 key
      exit 1
   fi

   if [ ! -x "$HOME/.cargo/bin/rustup" ]; then
      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
      if [ $? -ne 0 ]; then
         read -rsp $'Unable to install Rust. Please try again and, if the problem persists, provide this log to the developer.\nPress any key to close...\n' -n1 key
         exit 1
      fi
   fi

   . "$HOME/.cargo/env"
   cargo install --locked rsnaker --force
   if [ $? -ne 0 ]; then
      read -rsp $'Unable to install rsnake. Please try again and, if the problem persists, provide this log to the developer.\nPress any key to close...\n' -n1 key
      exit 1
   fi
fi

"$HOME/.cargo/bin/rsnake"
