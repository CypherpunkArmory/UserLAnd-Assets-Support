#!/support/common/busybox_static sh

if [ ! -f /support/rootfs.tar.gz ]; then
   /support/common/busybox_static cat /support/rootfs.tar.gz.part* > /support/rootfs.tar.gz 
   /support/common/busybox_static rm -f /support/rootfs.tar.gz.part*
fi

/support/common/busybox_static tar -tzf /support/rootfs.tar.gz | /support/common/busybox_static grep -vE '^(sys|dev|proc|data|mnt|host-rootfs|support|sdcard|etc/mtab|usr/local/bin/sudo|etc/profile.d/userland_profile.sh|etc/ld.so.preload)' | /support/common/busybox_static xargs /support/common/busybox_static tar -xzvf /support/rootfs.tar.gz -C /

if [[ $? == 0 ]]; then
	/support/common/addNonRootUser.sh
	/support/common/busybox_static touch /support/.success_filesystem_extraction
else
	/support/common/busybox_static touch /support/.failure_filesystem_extraction
fi
