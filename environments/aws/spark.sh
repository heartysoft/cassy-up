#!/bin/bash

export SCRIPT_ROOT="/tmp/cassy-up"

echo "exporting vagrant specific default parameters..."

source "$SCRIPT_ROOT/spark_params.sh"

(cd $SCRIPT_ROOT/apache-spark && ./main.sh)
