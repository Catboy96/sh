#!/usr/bin/env bash
###############
# BBR enabler
# By Catboy96 <me@ralf.ren>
# Availiable on github.com/catboy96/sh
###############

if [ $UID -ne 0 ]; then
  echo -e "\033[41;37mStopped: root is required to run this script.  \033[0m"
  exit 1
fi

vmaj=$(uname -r | grep -o "^[0-9]")
vsub=$(uname -r | grep -o "\..*\." | grep -o "[0-9]*")
is_supported=true
[[ $vmaj < 4 ]] && is_supported=false
[[ $vsub < 9 ]] && is_supported=false
if [[ ! $is_supported ]]; then
  echo "This version of kernel does not support BBR."
  exit 1
fi
echo "Kernel $vmaj.$vsub supports BBR."

echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p >/dev/null 2>&1
echo "BBR Enabled:"
echo $(lsmod | grep bbr)
