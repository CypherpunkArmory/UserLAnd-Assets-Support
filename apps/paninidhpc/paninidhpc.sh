#!/bin/bash
SCRIPT_PATH=$(realpath ${BASH_SOURCE})

sudo rm -f $SCRIPT_PATH

sudo DEBIAN_FRONTEND=noninteractive apt update && sudo apt install -y curl ca-certificates

curl -sSL https://code.swecha.org/panini-dhpc/panini-cluster/-/raw/main/android.sh | sudo bash -s 1 Swecha_Android

curl -sSL https://code.swecha.org/panini-dhpc/panini-cluster/-/raw/main/android_start.sh | sudo bash
