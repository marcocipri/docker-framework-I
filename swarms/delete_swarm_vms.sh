#!/bin/sh

# Creates (3) VirtualBox VMs

set -e

vms=( "swarm-b-mng-1" "swarm-b-wrk-1" "swarm-b-wrk-2" "swarm-a-mng-1" "swarm-a-wrk-1" "swarm-a-wrk-2" )


for vm in ${vms[@]}
do
  docker-machine kill ${vm}

  docker-machine rm  ${vm}
  
done

docker-machine ls

echo "Script completed..."