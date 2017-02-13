#!/bin/bash

export SCRIPT_ROOT="/vagrant"

echo "exporting vagrant specific default parameters..."
if [ "x$ZOOKEEPER_DOWNLOAD_DIR" == "x" ]; then export ZOOKEEPER_DOWNLOAD_DIR=/vagrant/files/downloads/apache-zookeeper; fi

(cd $SCRIPT_ROOT/apache-zookeeper && ./main.sh)
