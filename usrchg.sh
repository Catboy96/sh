#!/usr/bin/env bash

help() {
    echo "usrchg by Catboy96 <me@ralf.ren>"
    echo ""
    echo "This script should be used to change default NON-ROOT username under SSH"
    echo "Usage: usrchg action options..."
    echo ""
    echo "Example usage under Ubuntu 18.04+:"
    echo "Step 1: usrchg init"
    echo "Re-login via SSH using root"
    echo ""
    echo "Step 2: usrchg change ubuntu catboy"
    echo "Re-login via SSH using new username"
    echo ""
}


init() {
    echo "[usrchg] Setting root password to enable root temporarily"
    sudo passwd root
    echo "[usrchg] Enable root login via SSH"
    sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sudo systemctl restart sshd.service
    echo ""
    echo "[usrchg] Now login via SSH using root,"
    echo "[usrchg] and run 'usrchg change [old-username] [new-username]'"
}

change() {
    [ ! $# = 2 ] && echo "Usage: usrchg change [old-username] [new-username]" && exit 0
    oldusr=$1
    newusr=$2
    echo "[usrchg] Change username and home"
    usermod -l $newusr $oldusr
    usermod -d /home/$newusr -m $newusr
    echo "[usrchg] Disable root"
    passwd -l root
    echo "[usrchg] Disable root login via SSH"
    sed -i 's/PermitRootLogin yes/#PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
    systemctl restart sshd.service
    echo ""
    echo "[usrchg] Now login via SSH using new username"
}

[ $# = 0 ] && help && exit 0
[ $UID -ne 0 ] && echo -e "root is required to run this script." && exit 1
[[ $1 =~ ^(init|change)$ ]] && $* || echo "Invalid option: $1"
