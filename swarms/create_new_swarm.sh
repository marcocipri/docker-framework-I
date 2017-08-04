#!/bin/sh

# Creates a new swarm for tokenmanager

bash create_swarm_vms.sh  ${1}
bash create_swarm.sh ${1}
bash deploy_consul_cli.sh ${1}
bash deploy_visualizer.sh ${1}
bash deploy_token_manager.sh ${1}