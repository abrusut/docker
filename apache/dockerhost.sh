#!/bin/bash
HOST=$(/bin/grep 'host.docker.internal' /etc/hosts)

if [[ "$HOST" = "" ]]
then
    apt-get install iproute2 -y
    ip -4 route list match 0/0 | awk '{print $3 " host.docker.internal"}' >> /etc/hosts
    apt-get remove --purge iproute2 -y
fi
