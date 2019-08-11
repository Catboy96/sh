#!/bin/bash
###############
# Tencent service remover
# By Catboy96 <me@ralf.ren>
# Availiable on github.com/catboy96/sh
###############

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH

if [ $UID -ne 0 ]; then
  echo -e "\033[41;37mStopped: root is required to run this script.  \033[0m"
  exit 1
fi

echo "Stopping SGAGENT..."
killall -9 sgagent

echo "Removing SGAGENT..."
rm -rf /usr/local/qcloud

echo "Removing SGAGENT configuration files..."
rm -rf /etc/qcloudzone

echo "Done."

