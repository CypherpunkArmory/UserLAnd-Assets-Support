#! /bin/bash

mkdir build

export ARCH_DIR=$(realpath output)/${1}
export RELEASE_DIR=$(realpath output)/release
export ASSETS_ARCH_DIR=$(realpath assets)/${1}
export ASSETS_ALL_DIR=$(realpath assets)/all
export PROOT_DIR=$(realpath build)/proot
export TERMUX_PACKAGES_DIR=$(realpath build)/termux-packages

case "$1" in
    x86)
        TERMUX_ARCH=i686
	ANDROID_ARCH=x86
        ;;
    arm)
        TERMUX_ARCH=arm
	ANDROID_ARCH=armeabi-v7a
        ;;
    x86_64)
        TERMUX_ARCH=x86_64
	ANDROID_ARCH=x86_64
        ;;
    arm64)
        TERMUX_ARCH=aarch64
	ANDROID_ARCH=arm64-v8a
        ;;
    all)
        exit
        ;;
    *)
        echo "unsupported architecture"
        exit
        ;;
esac

apt update
apt install -y git sudo curl unzip mawk zip python make build-essential lsb-release

rm -rf $ARCH_DIR
mkdir -p $ARCH_DIR

if [ ! -d $PROOT_DIR ]
then
    git clone https://github.com/termux/proot.git $PROOT_DIR
fi

if [ ! -d $TERMUX_PACKAGES_DIR ]
then
    git clone https://github.com/termux/termux-packages.git $TERMUX_PACKAGES_DIR
    cd $TERMUX_PACKAGES_DIR
    #git checkout -b userland 7f9d1ad9243cdcc0d477f8495091fe2bb9444569
    git fetch
    git checkout android-5
    scripts/setup-ubuntu.sh
    scripts/setup-android-sdk.sh
    sed -i 's/TERMUX_PKG_SRCDIR/PROOT_DIR/g' packages/proot/build.sh
    sed -i 's/make V=1/make clean\n        make V=1/g' packages/proot/build.sh
    sed -i 's/c1fd9b235896b1094ee97bfb7e042f93530b5e300781f59b45edf84ee8c75000/adf770dfd574a0d6026bfaa270cb6879b063957177a991d453ff1d302c02081f/g' packages/ca-certificates/build.sh
else
    cd $TERMUX_PACKAGES_DIR
fi

#build new
rm -rf /data/data/.built-packages/*
PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH libtalloc
cp /data/data/com.termux/files/usr/lib/libtalloc.so.2 $ARCH_DIR/libtalloc.so.2
PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH proot
cp /data/data/com.termux/files/usr/bin/proot $ARCH_DIR/proot
cp /data/data/com.termux/files/usr/libexec/proot/loader $ARCH_DIR/loader
cp /data/data/com.termux/files/usr/libexec/proot/loader32 $ARCH_DIR/loader32
#PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH openssl
#PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH termux-auth
#PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH dropbear
#cp /data/data/com.termux/files/usr/bin/dbclient $ARCH_DIR/dbclient
#cp /data/data/com.termux/files/usr/lib/libutil.so $ARCH_DIR/libutil.so
#cp /data/data/com.termux/files/usr/lib/libtermux-auth.so $ARCH_DIR/libtermux-auth.so
#cp /data/data/com.termux/files/usr/lib/libcrypto.so.1.1 $ARCH_DIR/libcrypto.so.1.1

#sudo PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH busybox
#cp /data/data/com.termux/files/usr/bin/busybox $ARCH_DIR/busybox
chmod 755 $ARCH_DIR/*

#copy over old and new
mkdir -p $ARCH_DIR/release
cp $ASSETS_ARCH_DIR/* $ARCH_DIR/release/
cp $ASSETS_ALL_DIR/* $ARCH_DIR/release/
cp $ARCH_DIR/* $ARCH_DIR/release/

#finishing touches before PR and release are built
rm $ARCH_DIR/release/assets.txt
mkdir -p $RELEASE_DIR
zip -j $RELEASE_DIR/$ANDROID_ARCH-assets.zip $ARCH_DIR/release/*
