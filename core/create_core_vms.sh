#!/bin/sh

# Creates (3) VirtualBox VMs which represents the core service based on consul for configuration repositoy,
# services discovery and healt checking

set -e

vms=( "core-vm1" "core-vm2" "core-vm3" )

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
