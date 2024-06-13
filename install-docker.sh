#!/bin/sh

echo "intatall: docker..."

echo "if networking nor run, pls start 'networking'!\n"
echo "rc-update add networking\n"
echo "rc-service networking service\n"

apk add --no-cache docker docker-cli-compose

if ! command -v openrc &> /dev/null
then 
  curl -o- https://raw.githubusercontent.com/khanh97dev/alpine/main/install-openrc.sh | bash -x
fi

rc-update add docker
rc-service docker restart
