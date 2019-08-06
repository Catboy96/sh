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
sudo cat > /etc/bash_completion.d/goto<<-EOF
_goto() {
    local cur prev nodes
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}“
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    screens=$(ls /var/run/screen/S-$USER | grep -oP "(?<=\.).*")

    case $prev in
        goto)
            COMPREPLY=( $(compgen -W "${screens}" -- ${cur}) )
            return;;
    esac
} complete -o default -F _goto goto
EOF

echo "Now, run 'source ~/.bashrc' to apply patches."

