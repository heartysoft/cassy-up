#!/bin/bash

export SCRIPT_ROOT="/tmp/cassy-up"

source "$SCRIPT_ROOT/flink_params.sh"

(cd $SCRIPT_ROOT/apache-flink && ./main.sh)

echo "flink installed. bye bye."
