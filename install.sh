#!/bin/bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

INSTALL_LOC=${1:-$HOME/.bashrc}
JUMPFILE=$DIR/index.sh

set +e
IS_INSTALLED=$(grep "$JUMPFILE" $INSTALL_LOC)
II_RET=$?
set -e

if [ $II_RET -ne 0 ]; then
  echo "Installing jumpfiles"
  echo "" >> $INSTALL_LOC
  echo "# Load Jumpfiles (https://github.com/hofstadter-io/jumpfiles)" >> $INSTALL_LOC
  echo ". $JUMPFILE" >> $INSTALL_LOC
  echo "" >> $INSTALL_LOC
fi
