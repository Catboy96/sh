#!/usr/bin/env bash
###############
# OpenWRT build essential
# By Catboy96 <me@ralf.ren>
###############

help() {
    echo "OpenWRT build essestial"
    echo "By Catboy96 <me@ralf.ren>"
    echo ""
    echo "Usage: bash openwrt-build-essential.sh version platform architecture"
    echo ""
    echo "For example, for OpenWRT 19.07 on Sunxi Cortex-A7 platform:"
    echo "bash openwrt-build-essential.sh 19.07 sunxi cortex-a7"
    echo ""
}

component_progress_bar() {
    source <(curl -s https://raw.githubusercontent.com/pollev/bash_progress_bar/master/progress_bar.sh)
}

error_exit() {
    destroy_scroll_area
    echo $1
    exit 1
}

bootstrap() {
    echo "Loading components..."
    component_progress_bar
    setup_scroll_area

    echo "Updating source..."
    sudo apt -o Dpkg::Progress-Fancy=0 update
    draw_progress_bar 15

    echo "Installing utilities..."
    sudo apt -o Dpkg::Progress-Fancy=0 install -y vim curl wget htop screen
    draw_progress_bar 30

    echo "Installing builders..."
    sudo apt -o Dpkg::Progress-Fancy=0 install -y build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf
    draw_progress_bar 50

    echo "Checking if SDK exists: $1 $2/$3..."
    result=$(curl -s https://downloads.openwrt.org/releases/$1/targets/$2/$3/ | grep -oP "(?<=href\=\")openwrt-sdk-$1-$2-$3.*?(?=\">)")
    draw_progress_bar 50
    [ -z "$result" ] && error_exit "SDK does not exist."
    echo "Got SDK: $result"

    echo "Downloading SDK..."
    wget https://downloads.openwrt.org/releases/$1/targets/$2/$3/$result -O $result
    draw_progress_bar 70

    echo "Extracting SDK..."
    tar xvf $result
    draw_progress_bar 95

    echo "Cleaning..."
    rm -f $result
    draw_progress_bar 99

    sleep 1
    destroy_scroll_area
    echo "Done."
}

[ ! $# = 3 ] && help && exit 0
[ -z $(which apt) ] && echo -e "\033[41;37mDebian based distro is required.\033[0m" && exit 1
bootstrap $1 $2 $3
