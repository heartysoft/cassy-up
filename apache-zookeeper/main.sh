#!/bin/bash
source ./zookeeper-params.sh

./zookeeper-get-files.sh
./zookeeper-configure.sh
./zookeeper-service.sh

service zookeeper start