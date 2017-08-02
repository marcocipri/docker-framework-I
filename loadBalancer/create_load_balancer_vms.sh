#!/bin/sh

# Creates loadBalancer VirtualBox VMs

set -e

vms=( "lb-${1}")

  docker-machine create \
    --driver virtualbox \
    --virtualbox-memory "1024" \
    --virtualbox-cpu-count "1" \
    --virtualbox-disk-size "20000" \
    --engine-label purpose=backend \
    ${vms[0]}
