#!/support/common/busybox_static sh

/support/common/addNonRootUser.sh
/support/common/busybox_static rm /support/rootfs.tar.gz
/support/common/busybox_static touch /support/.success_filesystem_extraction

