#!/bin/bash

export SCRIPT_ROOT="/tmp/cassy-up"

chmod a+x $SCRIPT_ROOT/oracle-jdk/main.sh

(cd $SCRIPT_ROOT/oracle-jdk && ./main.sh)
