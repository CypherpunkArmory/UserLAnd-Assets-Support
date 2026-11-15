#! /bin/bash

if [[ -z "${INITIAL_USERNAME}" ]]; then
  INITIAL_USERNAME="user"
fi
if [[ -z "${INITIAL_PASSWORD}" ]]; then
  INITIAL_PASSWORD="userland"
fi
if [[ -z "${INITIAL_VNC_PASSWORD}" ]]; then
  INITIAL_VNC_PASSWORD="userland"
fi

# The app's own libraries are on LD_LIBRARY_PATH, for PRoot. Linux programs here
# would load them in place of their own: Fedora's chpasswd loads pam_pwquality,
# whose libz.so.1 was then Android's, so PAM failed ("Module is unknown"), the
# password was never set, and the account stayed locked -- SSH logins refused.
unset LD_LIBRARY_PATH

if [ ! -d "/home/$INITIAL_USERNAME" ]; then
  useradd $INITIAL_USERNAME -s /bin/bash -m -u 2000 
  echo $INITIAL_USERNAME:$INITIAL_PASSWORD | chpasswd
  echo "/bin/bash" >> /etc/shells
  chsh -s /bin/bash $INITIAL_USERNAME
fi
