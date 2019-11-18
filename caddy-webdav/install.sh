#!/bin/bash
###############
# Caddy WebDAV installer
# By Catboy96 <me@ralf.ren>
# Availiable on github.com/catboy96/sh
###############

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH

if [ $UID -ne 0 ]; then
    echo -e "\033[41;37mStopped: root is required to run this script.  \033[0m"
    exit 1
fi

echo ""
echo "Customize your WebDAV installation:"
domain=$(read -p "Domain name: ")
email=$(read -p "Email (for Let's Encrypt): ")
user=$(read -p "WebDAV username: ")
pass=$(read -p "WebDAV password: ")

echo "Installing cURL..."
apt update
apt install curl -y

echo "Insalling Caddy with WebDAV extension..."
curl https://getcaddy.com | bash -s personal http.webdav

echo "Configurating Caddy..."
mkdir -p /etc/caddy/
wget https://raw.githubusercontent.com/Catboy96/sh/master/caddy-webdav/Caddyfile -O /etc/caddy/Caddyfile
sed -i "s/DOMAINNAME/$domain/g" /etc/caddy/Caddyfile
sed -i "s/EMAIL/$email/g" /etc/caddy/Caddyfile
sed -i "s/USERNAME/$user/g" /etc/caddy/Caddyfile
sed -i "s/PASSWORD/$pass/g" /etc/caddy/Caddyfile

echo "Configurating service..."
wget https://raw.githubusercontent.com/Catboy96/sh/master/caddy-webdav/caddy.service -O /usr/lib/systemd/system/caddy.service
systemctl enable caddy.service
systemctl start caddy.service

echo "Done. You can check Caddy running status by 'systemctl status caddy'."
echo "Also, consider increasing files limit by 'ulimit -n 8192' then restart Caddy."