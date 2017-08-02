#!/bin/sh

# Deploys a single instance Mano Marks’ Docker Swarm Visualizer to a swarm Manager node

set -e

consuls=( "core-vm1" "core-vm2" "core-vm3" )
CONSUL_MANAGER_IP=$(docker-machine ip ${consuls[0]})

SWARM_MANAGER="swarm-${1}-mng-1"
SWARM_MANAGER_IP=$(docker-machine ip ${SWARM_MANAGER})
echo ${SWARM_MANAGER_IP}
eval $(docker-machine env ${SWARM_MANAGER})
echo ${SWARM_MANAGER}

  docker run -d \
    --net=host \
    -e 'CONSUL_ALLOW_PRIVILEGED_PORTS=' \
    --hostname consul-swarm-${1} \
    --name consul-swarm-${1} \
    --env "SERVICE_IGNORE=true" \
    --env "CONSUL_CLIENT_INTERFACE=eth0" \
    --env "CONSUL_BIND_INTERFACE=eth1" \
    --volume consul_data:/consul/data \
    -p 8300:8300 \
    -p 8301:8301 \
    -p 8301:8301/udp \
    -p 8302:8302/udp \
    -p 8302:8302 \
    -p 8400:8400 \
    -p 8500:8500 \
    -p 53:8600/udp \
    -p 8600:8600/tcp \
    consul:latest consul agent \
      -dns-port=53 \
      -recursor=8.8.8.8 \
      -client=0.0.0.0 \
      -advertise='{{ GetInterfaceIP "eth1" }}' \
      -retry-join=${CONSUL_MANAGER_IP} \
      -data-dir="/consul/data"

echo "Script completed..."