#!/data/data/tech.ula/files/support/busybox sh

$ROOT_PATH/support/busybox clear

#launch PRoot
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin PROOT_TMP_DIR=$ROOTFS_PATH/support/ $ROOT_PATH/support/proot -r $ROOTFS_PATH -v $PROOT_DEBUG_LEVEL -p -H -0 -l -L -b /sys -b /dev -b /proc -b /data -b /mnt -b /proc/mounts:/etc/mtab -b /:/host-rootfs -b $ROOTFS_PATH/support/:/support -b $ROOTFS_PATH/support/ld.so.preload:/etc/ld.so.preload $EXTRA_BINDINGS $@
