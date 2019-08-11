#!/bin/bash
###############
# Easy screen patcher
# By Catboy96 <me@ralf.ren>
# Availiable on github.com/catboy96/sh
###############

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH

echo "Removing alias..."
sed -e '/# Easy screen patch/d' ~/.bashrc > ~/.bashrc
sed -e '/alias works/d' ~/.bashrc > ~/.bashrc
sed -e '/alias goto/d' ~/.bashrc > ~/.bashrc
sed -e '/alias new/d' ~/.bashrc > ~/.bashrc

echo "Disabling tab complete..."
sudo rm -f /etc/bash_completion.d/easy-screen

echo "Now, run 'source ~/.bashrc' to disable patches."
