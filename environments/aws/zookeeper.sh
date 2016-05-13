#!/bin/bash

export SCRIPT_ROOT="/tmp/cassy-up"

echo "exporting aws specific default parameters..."

source "$SCRIPT_ROOT/zookeeper_params.sh"

(cd $SCRIPT_ROOT/apache-zookeeper && ./main.sh)
