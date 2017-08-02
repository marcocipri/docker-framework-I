#!/bin/sh

# Deploys a single instance of (haproxy+consulTemplate based) Load Balancer

set -e

LOAD_BALANCER="lb-${1}"
LOAD_BALANCER_IP=$(docker-machine ip ${LOAD_BALANCER})

echo ${LOAD_BALANCER}
SERVICE_PORT=1080

docker run -p 8080:80 -p ${SERVICE_PORT}:1080 \
 -e "CONSUL_ADDRESS=${LOAD_BALANCER}" \
 -e "CONSUL_PORT=8500"  \
 token-lb


echo "Script completed..."
