#!/bin/sh

echo 'install: openrc ...'

apk add --no-cache openrc
if ! -d /run/openrc
then
  mkdir -p /run/openrc
fi
# handle
openrc
touch /run/openrc/softlevel
