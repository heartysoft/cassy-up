#!/bin/bash

export SCRIPT_ROOT="/vagrant"

if [ "x$CASSANDRA_CLUSTER_NAME" == "x" ]; then export CASSANDRA_CLUSTER_NAME="dev"; fi
if [ "x$CASSANDRA_SNITCH" == "x" ]; then export CASSANDRA_SNITCH="GossipingPropertyFileSnitch"; fi
if [ "x$CASSANDRA_DC" == "x" ]; then export CASSANDRA_DC="dev1"; fi
if [ "x$CASSANDRA_RACK" == "x" ]; then export CASSANDRA_RACK="rack1"; fi
if [ "x$CASSANDRA_DC_SUFFIX" == "x" ]; then export CASSANDRA_DC_SUFFIX="_dev_cassandra"; fi

chmod a+x $SCRIPT_ROOT/dse-cassandra/main.sh

(cd $SCRIPT_ROOT/dse-cassandra && ./main.sh)

echo "DSE Cassandra installed. bye bye."
