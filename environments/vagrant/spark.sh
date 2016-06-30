#!/bin/bash

export SCRIPT_ROOT="/vagrant"

if [ "x$SPARK_DOWNLOAD_DIR" == "x" ]; then export SPARK_DOWNLOAD_DIR="/vagrant/files/downloads/spark/"; fi

if [ "x$SPARK_LOCAL_IP" == "x" ]; then export SPARK_LOCAL_IP=`hostname -I | awk '{print $NF}'`; fi

if [ "x$SPARK_MAX_WORKER_CORES" == "x" ]; then export SPARK_MAX_WORKER_CORES=2; fi
if [ "x$SPARK_MAX_WORKER_RAM" == "x" ]; then export SPARK_MAX_WORKER_RAM='2GB'; fi

(cd $SCRIPT_ROOT/apache-spark && ./main.sh)

echo "spark installed. bye bye."
