#!/bin/bash

# DDNS Automator for Brook
# By: Catboy96 <me@ralf.ren>
# Availiable at: github.com/catboy96/sh

hostname="nat1.superbear.cc"
brook_conf="/usr/local/brook-pf/brook.conf"
brook_service_log="/usr/local/brook-pf/brook_service.log"
ipv4_cache_file="/usr/local/brook-pf/ipv4_cache"

# resolve the domain name
ipv4=$(dig $hostname A +short)
ipv4_cache=$(cat $ipv4_cache_file)

# exit if ipv4 is not changed
if [ "$ipv4" == "$ipv4_cache" ]; then 
  exit 0
fi

# replace brook.conf
sed -i "s/${ipv4_cache}/${ipv4}/g" $brook_conf >/dev/null 2>&1

# restart brook
/etc/init.d/brook-pf restart >> $brook_service_log 2>&1

# save ipv4 cache
echo "$ipv4" > $ipv4_cache_file
