#!/bin/sh
echo "if networking nor run, pls start 'networking'!\n"
echo "rc-update add networking\n"
echo "rc-service networking service\n"

echo "installing..."
apk add --no-cache docker docker-cli-compose

if ! command -v openrc &> /dev/null
then
  echo 'install: openrc ...'
  apk add openrc
  if ! -d /run/openrc
  then
    mkdir -p /run/openrc
  fi
  # handle
  openrc
  touch /run/openrc/softlevel
fi

echo "add: boot..."
rc-update add docker
rc-service docker restart
