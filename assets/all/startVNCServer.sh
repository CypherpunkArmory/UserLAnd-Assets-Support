#! /support/common/busybox_static sh

unset LD_LIBRARY_PATH

if [[ -z "${INITIAL_USERNAME}" ]]; then
  INITIAL_USERNAME="user"
fi

#weirdly need to reconfigure xfonts-base for armhf after extraction
if [ ! -f /support/.reconfigure_xfonts ]; then
   dpkg-reconfigure xfonts-base
   touch /support/.reconfigure_xfonts
fi

su $INITIAL_USERNAME -c /support/startVNCServerStep2.sh
