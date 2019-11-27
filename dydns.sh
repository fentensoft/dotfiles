#!/usr/bin/bash

[ -z "$2" ] && echo "Usage: dydns.sh domain password interface" && exit
domain="$1"
password="$2"
interface="$3"
if [ ! -z "$interface" ]
then
    ip=$(ip addr show $interface 2>/dev/null | awk '/inet / {gsub(/\/.*/,"",$2); print $2}' | tr -d '[:space:]')
    if [ ! -z "$ip" ]
    then
        echo "Setting domain $domain A record to $ip"
        curl -s "https://dyn.dns.he.net/nic/update?hostname=$domain&password=$password&myip=$ip"
    fi
else
    echo "Setting domain $domain A record to auto detect ip"
    curl -s "https://dyn.dns.he.net/nic/update?hostname=$domain&password=$password"
fi

