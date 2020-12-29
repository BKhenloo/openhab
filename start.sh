#! /usr/bin/env bash

## Create openhab user
echo $(adduser --no-create-home --user-group --uid $UID --gid $GID openhab)

## Copy openHAB content to working dir, if empty
if [ -z "$(ls -A /opt/openhab)" ]; then
  echo "Copy openHAB content to working directory..."
  tar xafv /tmp/openhab.tar.gz
else
  echo "Found existing openHAB..."
fi

## Set ownership of working dir
chown openhab:openhab -R /opt/openhab

## Start openHAB instance 
sudo -u openhab /usr/bin/env bash -c '/opt/openhab/start.sh'
