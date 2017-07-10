#!/bin/sh

# Installs Consul Agents on all core's nodes 

# set -e

vms=( "core-vm1" "core-vm2" "core-vm3" )
consul_servers=( "consul-server1" "consul-server2" "consul-server3" )


SWARM_MANAGER_IP=$(docker-machine ip ${vms[0]})
echo ${SWARM_MANAGER_IP}

# initial consul server
consul_server=${consul_servers[0]}

docker-machine env ${vms[0]}
eval $(docker-machine env ${vms[0]})

docker run -d \
  --net=host \
  --hostname ${consul_server} \
  --name ${consul_server} \
  --env "SERVICE_IGNORE=true" \
  --env "CONSUL_CLIENT_INTERFACE=eth0" \
  --env "CONSUL_BIND_INTERFACE=eth1" \
  --volume consul_data:/consul/data \
  --publish 8500:8500 \
  consul:latest \
  consul agent -server -ui \
    -bootstrap-expect=3 \
    -client=0.0.0.0 \
    -advertise=${SWARM_MANAGER_IP} \
    -data-dir="/consul/data"


# next two consul servers
i=1
for vm in ${vms[@]:1:2}
do
  docker-machine env ${vm}
  eval $(docker-machine env ${vm})

  docker run -d \
    --net=host \
    --hostname ${consul_servers[i]} \
    --name ${consul_servers[i]} \
    --env "SERVICE_IGNORE=true" \
    --env "CONSUL_CLIENT_INTERFACE=eth0" \
    --env "CONSUL_BIND_INTERFACE=eth1" \
    --volume consul_data:/consul/data \
    --publish 8500:8500 \
    consul:latest \
    consul agent -server -ui \
      -client=0.0.0.0 \
      -advertise='{{ GetInterfaceIP "eth1" }}' \
      -retry-join=${SWARM_MANAGER_IP} \
      -data-dir="/consul/data"

  let "i++"
done

docker-machine env ${vms[0]}
eval $(docker-machine env ${vms[0]})
docker exec -it ${consul_servers[0]} consul members

echo "Script completed..."
