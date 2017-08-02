#!/bin/bash

## docker startup 

HAPROXY="/usr/local/etc/haproxy"
PIDFILE="/run/haproxy.pid"
CONFIG_FILE=${HAPROXY}/haproxy.cfg

echo "starting haProxy"
/usr/local/sbin/haproxy -f /usr/local/etc/haproxy/haproxy.cfg -p /var/run/haproxy.pid -D -st $(pidof haproxy) 
echo "started haProxy"

##/usr/local/sbin/haproxy -p /tmp/haproxy.pid -f /usr/local/etc/haproxy/haproxy.cfg -D -st $(pidof haproxy)
##/usr/local/sbin/haproxy -p /run/haproxy.pid -f /usr/local/etc/haproxy/haproxy.cfg -Ds
echo "starting consulTemplate"
/usr/bin/consul-template -consul-addr="${CONSUL_ADDRESS}:${CONSUL_PORT}" -config=/usr/local/etc/consul/consul.hcl -template "/usr/local/etc/consul/in.tpl:out.txt"
echo "starting closed"