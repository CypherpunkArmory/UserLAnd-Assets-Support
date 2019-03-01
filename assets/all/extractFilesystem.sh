#!/support/common/busybox_static sh

if [ ! -f /support/rootfs.tar.gz ]; then
   /support/common/busybox_static cat /support/rootfs.tar.gz.part* > /support/rootfs.tar.gz 
   /support/common/busybox_static rm -f /support/rootfs.tar.gz.part*
fi

#only untar directories we might use and put it in a temp directory
/support/common/busybox_static mkdir /tartmp
/support/common/busybox_static tar -tzf /support/rootfs.tar.gz | /common/busybox_static grep '^[^/]*/$' | /support/common/busybox_static grep -vE '^(sys|dev|proc|data|mnt|host-rootfs|support|sdcard)' | /support/common/busybox_static xargs /support/common/busybox_static tar -xzvf /support/rootfs.tar.gz -C /tartmp
#delete specific files we are going to replace with bindings
/support/common/busybox_static rm -rf /tartmp/etc/mtab
/support/common/busybox_static rm -rf /tartmp/usr/local/bin/sudo
/support/common/busybox_static rm -rf /tartmp/etc/profile.d/userland_profile.sh
/support/common/busybox_static rm -rf /tartmp/etc/ld.so.preload
#move it to / and delete the temp directory
/support/common/busybox_static mv /tartmp/* /
/support/common/busybox_static rm -rf /tartmp

if [[ $? == 0 ]]; then
	/support/common/addNonRootUser.sh
	/support/common/busybox_static touch /support/.success_filesystem_extraction
else
	/support/common/busybox_static touch /support/.failure_filesystem_extraction
fi
