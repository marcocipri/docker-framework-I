#!/bin/sh

# Deploys a single instance Mano Marks’ Docker Swarm Visualizer to a swarm Manager node

set -e

SWARM_MANAGER_IP=$(docker-machine ip swarm-${1}-mng-1)
echo ${SWARM_MANAGER_IP}


docker-machine ssh swarm-${1}-mng-1 \
  "docker service rm token-manager"


echo "Script completed..."