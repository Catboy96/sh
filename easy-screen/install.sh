#!/bin/bash
###############
# Easy screen patcher
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
sudo apt update

echo "Installing screen..."
sudo apt install screen -y

echo "Making alias..."
echo "" >> ~/.bashrc
echo "# Easy screen patch" >> ~/.bashrc
echo "alias works='screen -ls'" >> ~/.bashrc
echo "alias goto='screen -r'" >> ~/.bashrc
echo "alias new='screen -S'" >> ~/.bashrc
echo "" >> ~/.bashrc

echo "Enabling tab complete..."
sudo wget -O /etc/bash_completion.d/easy-screen https://raw.githubusercontent.com/Catboy96/sh/master/easy-screen/easy-screen

echo "Now, run 'source ~/.bashrc' to apply patches."
