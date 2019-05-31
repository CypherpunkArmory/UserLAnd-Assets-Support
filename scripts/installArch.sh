#! /bin/bash

export ARCH_DIR=output/$1
export INSTALL_DIR=assets/$1

case "$1" in
    x86)
        cp $ARCH_DIR/* $INSTALL_DIR/
        ;;
    arm)
        cp $ARCH_DIR/* $INSTALL_DIR/
        ;;
    x86_64)
        cp $ARCH_DIR/* $INSTALL_DIR/
        ;;
    arm64)
        cp $ARCH_DIR/* $INSTALL_DIR/
        ;;
    all)
        ;;
    *)
        echo "unsupported architecture"
        exit
        ;;
esac

