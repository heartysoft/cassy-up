#!/bin/bash

export SCRIPT_ROOT="/vagrant"

chmod a+x $SCRIPT_ROOT/oracle-jdk/main.sh
(cd $SCRIPT_ROOT/oracle-jdk && ./main.sh)
