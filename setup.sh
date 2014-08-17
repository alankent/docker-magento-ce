#!/usr/bin/env bash

# stop on errors
set -e
# turn on debugging
set -x

if [ "$ENV_MODE" = "dev" ]; then
  cp /magento/errors/local.xml.sample /magento/errors/local.xml
  echo -e "
xdebug.remote_enable=On
xdebug.idekey=dmd_xdebug
xdebug.remote_host=$REMOTE_IP
" >> /etc/php5/mods-available/xdebug.ini
fi
