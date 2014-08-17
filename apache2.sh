#!/bin/sh

. /etc/apache2/envvars
mkdir -p /var/lock/apache2
mkdir -p /var/run/apache2
/usr/sbin/apache2 -D FOREGROUND
