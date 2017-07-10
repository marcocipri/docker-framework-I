#!/bin/sh

# Creates Docker swarm using (6) VirtualBox VMs

set -e

vms=( "swarm-a-mng-1" "swarm-a-wrk-1" "swarm-a-wrk-2" )


SWARM_MANAGER_IP=$(docker-machine ip ${vms[0]})
echo ${SWARM_MANAGER_IP}

docker-machine ssh ${vms[0]} \
  "docker swarm init \
  --advertise-addr ${SWARM_MANAGER_IP}"

docker-machine env ${vms[0]}
eval $(docker-machine env ${vms[0]})



WORKER_SWARM_JOIN=$(docker-machine ssh ${vms[0]} "docker swarm join-token worker")
WORKER_SWARM_JOIN=$(echo ${WORKER_SWARM_JOIN} | grep -E "(docker).*(2377)" -o)
WORKER_SWARM_JOIN=$(echo ${WORKER_SWARM_JOIN//\\/''})
echo ${WORKER_SWARM_JOIN}

# three worker nodes
for vm in ${vms[@]:1:2}
do
  docker-machine ssh ${vm} ${WORKER_SWARM_JOIN}
done

docker node ls

docker-machine env ${vms[0]}
eval $(docker-machine env ${vms[0]})

# create overlay network for stack
docker network create \
  --driver overlay \
  --subnet=10.0.0.0/16 \
  --ip-range=10.0.11.0/24 \
  --opt encrypted \
  --attachable=true \
  swarm_a_overlay_net


echo "Script completed..."