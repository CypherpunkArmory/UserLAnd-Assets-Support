#!/data/data/tech.ula/files/support/busybox sh

if [[ -z "${LIB_PATH}" ]]; then
  LIB_PATH="$ROOT_PATH/support"
fi

$LIB_PATH/busybox clear

$LIB_PATH/busybox rm -rf $1
$LIB_PATH/busybox chmod +rwx -R $1
$LIB_PATH/busybox rm -rf $1
