#!/bin/bash
###############
# Aliyun service remover
# By Catboy96 <me@ralf.ren>
# Availiable on github.com/catboy96/sh
###############

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH

if [ $UID -ne 0 ]; then
  echo -e "\033[41;37mStopped: root is required to run this script.  \033[0m"
  exit 1
fi

echo "Stopping AEGIS..."
killall -9 aegis_cli
killall -9 aegis_update
killall -9 aegis_cli

echo "Stopping QUARTZ..."
killall -9 aegis_quartz

echo "Removing AEGIS and QUARTZ..."
if [ -f "/etc/init.d/aegis" ]; then
 /etc/init.d/aegis stop
 rm -f /etc/init.d/aegis
fi
if [[ -d "/usr/local/aegis" ]]; then
  rm -rf /usr/local/aegis
fi

echo "Stopping ALIYUN_SERVICE..."
killall -9 aliyun-service

echo "Removing ALIYUN_SERVICE..."
if [[ -f "/usr/sbin/aliyun-service" ]]; then
  rm -f /usr/sbin/aliyun-service
fi

echo "Removing AGENTWATCH..."
if [[ -f "/etc/init.d/agentwatch" ]]; then
  rm -f /etc/init.d/agentwatch
fi

echo "Done."

