#!/bin/sh

# Deploys a single instance Mano Marks’ Docker Swarm Visualizer to a swarm Manager node

set -e

SWARM_MANAGER_IP=$(docker-machine ip swarm-${1}-mng-1)
echo ${SWARM_MANAGER_IP}
SERVICE_PORT=8080



docker-machine ssh swarm-${1}-mng-1 \
  "docker service create \
  --name token-manager \
  --replicas=2 \
  --publish ${SERVICE_PORT}:8080/tcp \
  --network swarm_${1}_overlay_net \
  --mode replicated -e "confserver=${SWARM_MANAGER_IP}" \
  -e "enviroment=test" \
  -e "serviceip=${SWARM_MANAGER_IP}" \
  -e "serviceport=${SERVICE_PORT}" \
  -e "deregister_after=1m" \
  -e "confurl=services/environment/test/token/encrypt-key" \
  marcocipri/tokenmanager"

echo "Script completed..."
