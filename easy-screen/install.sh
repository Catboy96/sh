#!/bin/bash
###############
# Easy screen patcher
# By Catboy96 <me@ralf.ren>
# Availiable on github.com/catboy96/sh
###############

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH

echo "Making alias..."
echo "" >> ~/.bashrc
echo "# Easy screen patch" >> ~/.bashrc
echo "alias works='screen -ls'" >> ~/.bashrc
echo "alias goto='screen -r'" >> ~/.bashrc
echo "alias new='screen -S'" >> ~/.bashrc
echo "" >> ~/.bashrc

echo "Enabling tab complete..."
sudo echo "_goto() {" > /etc/bash_completion.d/goto
sudo echo "    local cur prev nodes" >> /etc/bash_completion.d/goto
sudo echo "    COMPREPLY=()" >> /etc/bash_completion.d/goto
sudo echo "    cur=\"${COMP_WORDS[COMP_CWORD]}\"" >> /etc/bash_completion.d/goto
sudo echo "    prev=\"${COMP_WORDS[COMP_CWORD-1]}\"" >> /etc/bash_completion.d/goto
sudo echo "    screens=$(ls /var/run/screen/S-$USER | grep -oP \"(?<=\.).*\")" >> /etc/bash_completion.d/goto
sudo echo "" >> /etc/bash_completion.d/goto
sudo echo "    case $prev in" >> /etc/bash_completion.d/goto
sudo echo "        goto)" >> /etc/bash_completion.d/goto
sudo echo "            COMPREPLY=( $(compgen -W \"${screens}\" -- ${cur}) )" >> /etc/bash_completion.d/goto
sudo echo "            return;;" >> /etc/bash_completion.d/goto
sudo echo "    esac" >> /etc/bash_completion.d/goto
sudo echo "} complete -o default -F _goto goto" >> /etc/bash_completion.d/goto

echo "Now, run 'source ~/.bashrc' to apply patches."
