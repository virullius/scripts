#!/bin/sh

# If script is not run as root, check for sudo command and execute self with
# sudo. Otherwise, if sudo command is not found, exit with error message.

if [ $(id -u) -gt 0 ]; then
  if [ -x $(command -v sudo) ]; then
    exec sudo "$0" $@
  fi
  echo "Get root." >&2
  exit 1
fi

echo "Do root's work here."