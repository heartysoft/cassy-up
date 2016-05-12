#!/bin/bash

export SCRIPT_ROOT="/tmp/cassy-up"

echo "exporting aws specific default parameters..."

source "$SCRIPT_ROOT/zookeepers.sh"

(cd $SCRIPT_ROOT/apache-zookeeper && ./main.sh)
