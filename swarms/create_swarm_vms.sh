#!/bin/sh

# Creates (6) VirtualBox VMs

set -e

vms=( "swarm-a-mng-1" "swarm-a-wrk-1" "swarm-a-wrk-2" "swarm-b-mng-1" "swarm-b-wrk-1" "swarm-b-wrk-2")

for vm in ${vms[@]}
do
  docker-machine create \
    --driver virtualbox \
    --virtualbox-memory "1024" \
    --virtualbox-cpu-count "1" \
    --virtualbox-disk-size "20000" \
    --engine-label purpose=backend \
    ${vm}
done

docker-machine ls

echo "Script completed..."
