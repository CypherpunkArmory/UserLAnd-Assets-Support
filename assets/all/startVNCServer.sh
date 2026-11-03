#! /bin/bash

unset LD_LIBRARY_PATH

if [[ -z "${INITIAL_USERNAME}" ]]; then
  INITIAL_USERNAME="user"
fi

#PRoot starts in the directory the app runs it from, /data/data/tech.ula/files, and the VNC
#server, the desktop and every terminal opened from its menu would all inherit that. Start
#them in the user's home instead, as a login would.
USER_HOME="$(awk -F: -v user="$INITIAL_USERNAME" '$1 == user { print $6 }' /etc/passwd)"
cd "${USER_HOME:-/home/$INITIAL_USERNAME}" 2>/dev/null

su $INITIAL_USERNAME -c /support/startVNCServerStep2.sh
