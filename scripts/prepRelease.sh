#! /bin/bash

export ARCH_DIR=$(realpath output)/$1
export INSTALL_DIR=$(realpath assets)/$1

case "$1" in
    x86)
        ANDROID_ARCH=x86
        ;;
    arm)
        ANDROID_ARCH=armeabi-v7a
        ;;
    x86_64)
        ANDROID_ARCH=x86_64
        ;;
    arm64)
        ANDROID_ARCH=arm64-v8a
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
mkdir -p $ARCH_DIR/../release
zip -j $ARCH_DIR/../release/$ANDROID_ARCH-assets.zip $ARCH_DIR/release/*
