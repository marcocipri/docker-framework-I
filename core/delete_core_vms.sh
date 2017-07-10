#!/bin/sh

# deletes core's VirtualBox VMs

set -e

vms=( "core-vm1" "core-vm2" "core-vm3" )


for vm in ${vms[@]}
do
  docker-machine kill ${vm}

  docker-machine rm  ${vm}

done

docker-machine ls

echo "Script completed..."