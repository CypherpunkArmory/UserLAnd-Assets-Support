#! /bin/bash

unset LD_LIBRARY_PATH

if [[ -z "${INITIAL_USERNAME}" ]]; then
  INITIAL_USERNAME="user"
fi

su $INITIAL_USERNAME -c /support/startVNCServerStep2.sh
