#!/bin/bash

export SCRIPT_ROOT="/tmp/cassy-up"

#cassandra_params must at least set:
# CASSANDRA_CLUSTER_NAME
# CASSANDRA_DC_SUFFIX
# CASSANDRA_EMAIL
# CASSANDRA_EMAIL
# CASSANDRA_SEEDS
source "$SCRIPT_ROOT/dse_cassandra_params.sh"

# If using Ec2MultiRegionSnitch, CASSANDRA_LISTEN_ADDRESS (private ip), 
# CASSANDRA_BROADCAST_ADDRESS (public ip) need to be set as well

if [ "x$CASSANDRA_SNITCH" == "x" ]; then export CASSANDRA_SNITCH="Ec2Snitch"; fi


(cd $SCRIPT_ROOT/dse-cassandra && ./main.sh)

echo "DSE cassandra installed. bye bye."
