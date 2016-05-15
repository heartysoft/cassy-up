#!/bin/bash

export SCRIPT_ROOT="/vagrant"

if [ "x$CASSANDRA_CLUSTER_NAME" == "x" ]; then export CASSANDRA_CLUSTER_NAME="dev"; fi
if [ "x$CASSANDRA_SNITCH" == "x" ]; then export CASSANDRA_SNITCH="GossipingPropertyFileSnitch"; fi
if [ "x$CASSANDRA_DC" == "x" ]; then export CASSANDRA_DC="dev1"; fi
if [ "x$CASSANDRA_RACK" == "x" ]; then export CASSANDRA_RACK="rack1"; fi
if [ "x$CASSANDRA_DC_SUFFIX" == "x" ]; then export CASSANDRA_DC_SUFFIX="_dev_cassandra"; fi

if [ "x$CASSANDRA_DOWNLOAD_DIR" == "x" ]; then export CASSANDRA_DOWNLOAD_DIR="/vagrant/files/downloads/apache-cassandra/"; fi


(cd $SCRIPT_ROOT/apache-cassandra && ./main.sh)

echo "cassandra installed. bye bye."
