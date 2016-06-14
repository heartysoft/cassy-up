#!/bin/bash

source ./cassandra-params.sh

source ./cassandra-get-files.sh
source ./cassandra-configure.sh
source ./cassandra-service.sh

service cassandra start


