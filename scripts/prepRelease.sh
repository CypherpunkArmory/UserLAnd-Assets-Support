#! /bin/bash

export ARCH_DIR=output/$1
export INSTALL_DIR=assets/$1

case "$1" in
    x86)
        ;;
    arm)
        ;;
    x86_64)
        ;;
    arm64)
        ;;
    *)
        echo "unsupported architecture"
        exit
        ;;
esac

rm -rf $ARCH_DIR/release
mkdir -p $ARCH_DIR/release
cp assets/all/* $ARCH_DIR/release/
cp $INSTALL_DIR/* $ARCH_DIR/release/
rm $ARCH_DIR/release/assets.txt
zip $ARCH_DIR/$1-assets.zip $ARCH_DIR/release/*
