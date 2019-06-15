#!/bin/bash
###############
# Install & Configure PetaLinux 2019.1 on Ubuntu 18.04 LTS
# by Catboy96 <me@ralf.ren>
# availiable on github.com/catboy96/#!/bin/sh
###############

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH

function help() {
  Hello
  echo "Usage：bash $0 [plnx-installer] [install-dir]"
  echo ""
  echo "  plnx-installer       PetaLinux installation file"
  echo "                       Use absolute path only"
  echo "  install-dir          Directory you wish the PetaLinux will be installed to"
  echo "                       Use absolute path only"
  echo ""
}

function checkDistro() {
  distro=`lsb_release -i | grep -oP "(?<=:).*"`
  version=`lsb_release -r | grep -oP "(?<=:).*"`
  if [ $distro != "Ubuntu" ] || [ $version != "18.04" ]; then
    echo "This script is for Ubuntu 18.04 only."
	exit 1
  fi
}

function installDependencies() {
  echo "Installing dependencies..."
  sudo apt install -y gcc git make net-tools libncurses5-dev tftpd zlib1g-dev libssl-dev flex bison libselinux1 gnupg wget diffstat chrpath socat xterm autoconf libtool tar unzip texinfo zlib1g-dev gcc-multilib build-essential libsdl1.2-dev libglib2.0-dev zlib1g:i386 screen pax gzip dos2unix tofrodos iproute2 gawk tftpd-hpa tftp
  echo "Done."
}

function createDir() {
  install_dir="$2"
  echo "Making installation directory..."
  sudo mkdir -p install_dir
  sudo chown -R $USER $install_dir
  echo "Done."
  echo "Making default TFTP directory..."
  sudo mkdir -p /tftpboot
  sudo chown -R $USER /tftpboot
  echo "Done."
}

function installPetalinux() {
  plnx_installer="$1"
  install_dir="$2"
  chmod a+x $plnx_installer
  echo "Starting PetaLinux installation..."
  $plnx_installer $install_dir
  echo "Petalinux Installation finished successfully."
}

function ttyUsbEnabler() {
  echo "Configurating udev for ttyUSB & ttyACM..."
  sudo echo "KERNEL==\"ttyUSB[0-9]*\",MODE=\"0666\"" >> /etc/udev/rules.d/90-ttyusb.rules
  sudo echo "KERNEL==\"ttyUSB[0-9]*\",MODE=\"0666\"" >> /etc/udev/rules.d/90-ttyusb.rules
  echo "Restarting udev service..."
  sudo systemctl restart udev.service
  echo "Done."
}

function aliasMaker() {
  install_dir="$2"
  echo "Making alias..."
  echo "# PetaLinux environment setup" >> ~/.bashrc
  echo "alias petalinux=\"source $install_dir/settings.sh\""
  echo "Done."
}

if [[ $# > 0 ]];then
    checkDistro
    installDependencies
    createDir
    installPetalinux
    ttyUsbEnabler
    aliasMaker
else
    checkDistro
    help
fi
