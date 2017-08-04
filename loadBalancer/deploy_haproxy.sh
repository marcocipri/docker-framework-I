#!/bin/sh

# Deploys a single instance of (haproxy+consulTemplate based) Load Balancer

set -e

LOAD_BALANCER="lb-${1}"
LOAD_BALANCER_IP=$(docker-machine ip ${LOAD_BALANCER})

echo ${LOAD_BALANCER}
SERVICE_PORT=1080
echo ${LOAD_BALANCER_IP}
eval $(docker-machine env ${LOAD_BALANCER})
echo ${LOAD_BALANCER}

docker run -d -p 8080:80 -p 1080:1080 \
--name lb-${1} \
 -e "CONSUL_ADDRESS=${LOAD_BALANCER_IP}" \
 -e "CONSUL_PORT=8500"  \
marcocipri/http-loadbalancer

echo "Script completed..."
