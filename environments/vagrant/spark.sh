#!/bin/bash

export SCRIPT_ROOT="/vagrant"

if [ "x$SPARK_DOWNLOAD_DIR" == "x" ]; then export SPARK_DOWNLOAD_DIR="/vagrant/files/downloads/spark/"; fi

(cd $SCRIPT_ROOT/apache-spark && ./main.sh)

echo "spark installed. bye bye."
