#!/bin/bash

source ./dse-cassandra-params.sh

source ./dse-cassandra-get-files.sh
source ./dse-cassandra-configure.sh

service dse start
