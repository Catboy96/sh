#!/bin/bash
###############
# WHMCScan installer
# By Catboy96 <me@ralf.ren>
# Availiable on github.com/catboy96/sh
###############

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH

if [ $UID -ne 0 ]; then
  echo -e "\033[41;37mStopped: root is required to run this script.  \033[0m"
  exit 1
fi

echo "Updating APT source..."
apt update

echo "Installing Python 3..."
apt install python3 python3-pip -y

echo "Installing requests..."
pip3 install requests

echo "Installing WHMCScan..."
wget https://raw.githubusercontent.com/Catboy96/sh/master/whmcscan/whmcscan -O /usr/bin/whmcscan
chmod a+x /usr/bin/whmcscan

echo "Done."
