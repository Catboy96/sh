#!/usr/bin/env python3
###############
# Simple systemd service configuration generator
# By Catboy96 <me@ralf.ren>
# Availiable on github.com/catboy96/sh
###############

import re
import os
import argparse

__VERSION__ = "1.0.0"


def ciao():
    parser = argparse.ArgumentParser(description='srvgen, a simple systemd service configuration generator.')
    parser.add_argument('name', help='service name')
    parser.add_argument('exec', help='run command')
    parser.add_argument('-d', dest='desc', help='service description')
    parser.add_argument('-p', dest='pidf', help='PID file')
    parser.set_defaults(func=gen)
    args = parser.parse_args()
    try:
        args.func(args)
    except AttributeError:
        parser.print_help()
        exit(0)


def gen(args):
    if not re.match(r'^[a-zA-Z0-9][A-Za-z0-9_-]*$', args.name):
        print('service name may only contain: letters, dash, underscore and numbers')
        exit(3)

    desc = args.name
    if args.desc:
        desc = args.desc

    pidf = "/var/run/%s.pid" % args.name
    if args.pidf:
        pidf = args.pidf

    f = open('/etc/systemd/system/%s.service' % args.name, 'w')
    f.write("""[Unit]
Description=%s
After=network.target
Wants=network.target

[Service]
Type=simple
PIDFile=%s
ExecStart=%s
Restart=on-failure

[Install]
WantedBy=multi-user.target""" % (desc, pidf, args.exec))
    f.close()
    print('/etc/systemd/system/%s.service saved.' % args.name)

if __name__ == '__main__':
    if not os.path.isfile('/bin/systemctl'):
        print('systemd is not supported on this os.')
        exit(1)
    if not os.getuid() == 0:
        print('srvgen must be run as root.')
        exit(2)
    ciao()
