#!/bin/sh

# Creates key values for central configuration

set -e

vms=( "core-vm1" "core-vm2" "core-vm3" )

SWARM_MANAGER_IP=$(docker-machine ip ${vms[0]})
echo ${SWARM_MANAGER_IP}


values=(
    '{"key":"passwTest","reloadTime":"20000"}'
    '{"key":"passwProd","reloadTime":"30000"}'
    '{"key":"passwDev","reloadTime":"40000"}'
)

keys=(
    'environment/test/token/encrypt-key'
    'environment/prod/token/encrypt-key'
    'environment/dev/token/encrypt-key'
)

i=0

for value in ${values[@]}
do
  curl -S -s -H "Content-Type: application/json" \
    -X PUT -d ${value} \
    "http://${SWARM_MANAGER_IP}:8500/v1/kv/services/${keys[i++]}" 
    echo "New key posted..."
done

echo "Conf script completed..."

### network configuration, port forward for DNS service

for vm in ${vms[@]}
do
echo "iptable for ${vm}..."
docker-machine ssh ${vm}  "sudo /usr/local/sbin/iptables -t nat -A PREROUTING -i eth1 -p udp --dport 53 -j REDIRECT --to-port 8600"
done

echo "Conf script completed..."

