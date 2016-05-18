#!/bin/bash

# configures flink

echo "configuring flink..."

mkdir -p $FLINK_LOG_DIR

rm $FLINK_DIR/conf/slaves || true

IFS=',' read -r -a FLINKSLAVES <<< "$FLINK_SLAVES"
for index in "${!FLINKSLAVES[@]}"
do
    echo "${FLINKSLAVES[index]}" >> $FLINK_DIR/conf/slaves
done

sed -i "s/jobmanager.rpc.address:.*/jobmanager.rpc.address: $FLINK_MASTER/g" $FLINK_DIR/conf/flink-conf.yaml
sed -i "s/jobmanager.heap.mb:.*/jobmanager.heap.mb: $FLINK_JOBMANAGER_HEAP/g" $FLINK_DIR/conf/flink-conf.yaml
sed -i "s/taskmanager.heap.mb:.*/taskmanager.heap.mb: $FLINK_TASKMANAGER_HEAP/g" $FLINK_DIR/conf/flink-conf.yaml

sed -i "s/log4j.appender.file=.*/log4j.appender.file=org.apache.log4j.RollingFileAppender/g" $FLINK_DIR/conf/log4j.properties
sed -i "s~log4j.appender.file.file=.*~log4j.appender.file.file=$FLINK_LOG_DIR/flink.log~g" $FLINK_DIR/conf/log4j.properties

echo "export FLINK_IS_MASTER=$FLINK_IS_MASTER" >> /etc/profile.d/flink.sh

echo "..configured"
