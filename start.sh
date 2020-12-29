#! /usr/bin/env bash

echo $(adduser --no-create-home --user-group --uid $UID --gid $GID openhab)

if [ -z "$(ls -A /opt/openhab)" ]; then
  echo "Copy openHAB content to working directory..."
  tar xafv /tmp/openhab.tar.gz
else
  echo "Found existing openHAB..."
fi

sudo -u openhab /usr/bin/env bash -c '/opt/openhab/start.sh'
