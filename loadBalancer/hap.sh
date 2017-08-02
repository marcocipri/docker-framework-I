#!/bin/bash

## actions in case of changing of Consul Core status

/usr/local/sbin/haproxy -f /usr/local/etc/haproxy/haproxy.cfg -p /var/run/haproxy.pid -D -st $(pidof haproxy) 
