#!/bin/sh

# Installs Consul Agents on all nodes in swarm
# (3) Consul Server Agents and (3) Consul Client Agents

# set -e

vms=( "core-vm1" "core-vm2" "core-vm3" )
consul_servers=( "consul-server1" "consul-server2" "consul-server3" )
 


i=0
for vm in ${vms[@]:0:3}
do
  docker-machine env ${vm}
  eval $(docker-machine env ${vm})

  docker stop consul-server1
  docker rm consul-server1

  let "i++"
done

docker-machine env manager1
eval $(docker-machine env ${vms[0]})
docker exec -it ${consul_servers[0]} consul members

echo "Script completed..."
