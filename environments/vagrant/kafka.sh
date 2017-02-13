#!/bin/bash

export SCRIPT_ROOT="/vagrant"

echo "exporting vagrant specific default parameters..."

if [ "x$KAFKA_DOWNLOAD_DIR" == "x" ]; then export KAFKA_DOWNLOAD_DIR=/vagrant/files/downloads/apache-kafka; fi
if [ "x$KAFKA_HEAP_OPTS" == "x" ]; then export KAFKA_HEAP_OPTS="-Xmx256M -Xms256M"; fi
if [ "x$KAFKA_ADVERTISED_HOST_NAME" == "x" ]; then export KAFKA_ADVERTISED_HOST_NAME="`ifconfig eth1 | awk -F ' *|:' '/inet addr/{print $4}'`"; fi


(cd $SCRIPT_ROOT/apache-kafka && ./main.sh)
