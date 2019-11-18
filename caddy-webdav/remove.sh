#!/bin/bash
###############
# Caddy WebDAV remover
# By Catboy96 <me@ralf.ren>
# Availiable on github.com/catboy96/sh
###############

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH

if [ $UID -ne 0 ]; then
    echo -e "\033[41;37mStopped: root is required to run this script.  \033[0m"
    exit 1
fi

echo "Stopping Caddy..."
systemctl stop caddy.service

echo "Removing service..."
systectl disable caddy.service
rm -f /usr/lib/systemd/system/caddy.service

echo "Removing configuration file..."
rm -rf /etc/caddy

echo "Removing Caddy..."
rm -f /usr/local/bin/caddy

echo "Done."
