#!/data/data/tech.ula/files/support/busybox sh

$ROOT_PATH/support/busybox clear

$ROOT_PATH/support/busybox rm -rf $1
$ROOT_PATH/support/busybox chmod +rwx -R $1
$ROOT_PATH/support/busybox rm -rf $1
