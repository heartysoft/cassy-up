#!/bin/bash

export SCRIPT_ROOT="/vagrant"

echo "exporting vagrant specific default parameters..."
if [ "x$FLINK_DOWNLOAD_DIR" == "x" ]; then export FLINK_DOWNLOAD_DIR=/vagrant/files/downloads/apache-files; fi

(cd $SCRIPT_ROOT/apache-flink && ./main.sh)
