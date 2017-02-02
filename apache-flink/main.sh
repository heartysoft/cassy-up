#!/bin/bash
source ./flink-params.sh

./flink-get-files.sh
./flink-configure.sh
./flink-service.sh

service flink start
