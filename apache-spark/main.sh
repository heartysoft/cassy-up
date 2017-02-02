#!/bin/bash

source ./spark-params.sh

./spark-get-files.sh
./spark-configure.sh
./spark-service.sh

service spark start


