#!/bin/bash

source ./kafka-params.sh

./kafka-get-files.sh
./kafka-configure.sh
./kafka-service.sh

service kafka start
