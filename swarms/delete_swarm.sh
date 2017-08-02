#!/bin/sh

# Reset Docker swarm cluster
# Remove all (6) VirtualBox VMs from swarm cluster

# set -ex

vms=( "swarm-${1}-mng-1" "swarm-${1}-wrk-1" "swarm-${1}-wrk-2")

for vm in ${vms[@]}
do
  docker-machine env ${vm}
  eval $(docker-machine env ${vm})
  docker swarm leave -f
  echo "Node ${vm} has left the swarm cluster..."
done

docker-machine env ${vms[0]}
eval $(docker-machine env ${vms[0]})

for vm in ${vms[@]:1}
do
  docker node rm ${vm}
  echo "Node ${vm} was removed from the swarm cluster..."
done

docker node rm ${vms[0]}
docker network rm swarm_a_overlay_net
docker node ls

echo "Script completed..."
