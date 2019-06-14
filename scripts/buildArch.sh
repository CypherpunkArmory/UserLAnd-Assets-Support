#! /bin/bash

mkdir output
mkdir build

export ARCH_DIR=$(realpath output)/${1}
export PROOT_DIR=$(realpath build)/proot
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
    git checkout -b userland 7f9d1ad9243cdcc0d477f8495091fe2bb9444569
    $TERMUX_PACKAGES_DIR/scripts/setup-ubuntu.sh
    sudo $TERMUX_PACKAGES_DIR/scripts/setup-android-sdk.sh
    sed -i 's/TERMUX_PKG_SRCDIR/PROOT_DIR/g' $TERMUX_PACKAGES_DIR/packages/proot/build.sh
    #sed -i 's/-DARG_MAX/-DUSERLAND -DARG_MAX/g' $TERMUX_PACKAGES_DIR/packages/proot/build.sh
    sed -i 's/export PROOT_UNBUNDLE_LOADER/#export PROOT_UNBUNDLE_LOADER/g' $TERMUX_PACKAGES_DIR/packages/proot/build.sh
    sed -i 's/make V=1/make clean\n        make V=1/g' $TERMUX_PACKAGES_DIR/packages/proot/build.sh
fi

cd $TERMUX_PACKAGES_DIR

#sudo PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH libtalloc
#cp /data/data/com.termux/files/usr/lib/libtalloc.so.2 $ARCH_DIR/libtalloc.so.2
sudo PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH proot
cp /data/data/com.termux/files/usr/bin/proot $ARCH_DIR/proot
cp /data/data/com.termux/files/usr/libexec/proot/loader $ARCH_DIR/loader
cp /data/data/com.termux/files/usr/libexec/proot/loader32 $ARCH_DIR/loader32
#sudo PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH dropbear
#cp /data/data/com.termux/files/usr/bin/dbclient $ARCH_DIR/dbclient
#cp /data/data/com.termux/files/usr/lib/libtermux-auth.so $ARCH_DIR/libtermux-auth.so
#cp /data/data/com.termux/files/usr/lib/libutil.so $ARCH_DIR/libutil.so
#cp /data/data/com.termux/files/usr/lib/libcrypto.so.1.1 $ARCH_DIR/libcrypto.so.1.1
#sudo PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH busybox
#cp /data/data/com.termux/files/usr/bin/busybox $ARCH_DIR/busybox
#sudo PROOT_DIR=$PROOT_DIR ./build-package.sh -f -a $TERMUX_ARCH openssh
#cp /data/data/com.termux/files/usr/bin/ssh $ARCH_DIR/ssh
#cp /data/data/com.termux/files/usr/lib/libandroid-support.so $ARCH_DIR/libandroid-support.so
#cp /data/data/com.termux/files/usr/lib/libcrypto.so.1.1 $ARCH_DIR/libcrypto.so.1.1
#cp /data/data/com.termux/files/usr/lib/libz.so.1 $ARCH_DIR/libz.so.1
#cp /data/data/com.termux/files/usr/lib/libssl.so.1.1 $ARCH_DIR/libssl.so.1.1
#cp /data/data/com.termux/files/usr/lib/libldns.so $ARCH_DIR/libldns.so
#cp /data/data/com.termux/files/usr/lib/libgssapi_krb5.so.2 $ARCH_DIR/libgssapi_krb5.so.2
#cp /data/data/com.termux/files/usr/lib/libkrb5.so.3 $ARCH_DIR/libkrb5.so.3
#cp /data/data/com.termux/files/usr/lib/libk5crypto.so.3 $ARCH_DIR/libk5crypto.so.3
#cp /data/data/com.termux/files/usr/lib/libcom_err.so.3 $ARCH_DIR/libcom_err.so.3
#cp /data/data/com.termux/files/usr/lib/libkrb5support.so.0 $ARCH_DIR/libkrb5support.so.0
#cp /data/data/com.termux/files/usr/lib/libandroid-glob.so $ARCH_DIR/libandroid-glob.so
