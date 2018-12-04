#! /bin/bash

export ARCH_DIR=$(realpath output/${1})
export PROOT_DIR=$(realpath build/proot)
export TERMUX_PACKAGES_DIR=build/termux-packages

case "$1" in
    x86)
        TERMUX_ARCH=i686
        ;;
    arm)
        TERMUX_ARCH=arm
        ;;
    x86_64)
        TERMUX_ARCH=x86_64
        ;;
    arm64)
        TERMUX_ARCH=aarch64
        ;;
    all)
        exit
        ;;
    *)
        echo "unsupported architecture"
        exit
        ;;
esac

rm -rf $ARCH_DIR
mkdir -p $ARCH_DIR

if [ ! -d $PROOT_DIR ]
then
    git clone https://github.com/CypherpunkArmory/proot.git $PROOT_DIR
fi

if [ ! -d $TERMUX_PACKAGES_DIR ]
then
    git clone https://github.com/termux/termux-packages.git $TERMUX_PACKAGES_DIR
    $TERMUX_PACKAGES_DIR/scripts/setup-ubuntu.sh
    sudo $TERMUX_PACKAGES_DIR/scripts/setup-android-sdk.sh
    sed -i 's/TERMUX_PKG_SRCDIR/PROOT_DIR/g' $TERMUX_PACKAGES_DIR/packages/proot/build.sh
    sed -i 's/-DARG_MAX/-DUSERLAND -DARG_MAX/g' $TERMUX_PACKAGES_DIR/packages/proot/build.sh
    sed -i 's/make V=1/make clean\n        make V=1/g' $TERMUX_PACKAGES_DIR/packages/proot/build.sh
fi

cd $TERMUX_PACKAGES_DIR

sudo PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH libtalloc
cp /data/data/com.termux/files/usr/lib/libtalloc.so.2 $ARCH_DIR/libtalloc.so.2
sudo PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH proot
cp /data/data/com.termux/files/usr/bin/proot $ARCH_DIR/proot
#sudo PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH busybox
#cp /data/data/com.termux/files/usr/bin/busybox $ARCH_DIR/busybox
