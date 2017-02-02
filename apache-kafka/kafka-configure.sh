# configures kafka

echo "configuring kafka..."

mkdir -p $KAFKA_DATA_DIR
mkdir -p $KAFKA_LOG_DIR
mkdir -p $KAFKA_LOG4J_DIR
mkdir -p "/etc/profile.d/"

echo "export KAFKA_HEAP_OPTS=\"$KAFKA_HEAP_OPTS\"" > /etc/profile.d/kafka.sh
printf '%s\n' "source /etc/profile.d/kafka.sh" >> /etc/bash.bashrc

sed -i "s/broker.id=0/broker.id=${KAFKA_BROKER_ID}/g" $KAFKA_DIR/config/server.properties
sed -i "s@/tmp/kafka-logs@${KAFKA_LOG_DIR}@g" $KAFKA_DIR/config/server.properties
sed -i "s/localhost:2181/${KAFKA_ZOOKEEPER_SERVERS}/g" $KAFKA_DIR/config/server.properties
sed -i "s/num.partitions=1/num.partitions=${KAFKA_NUM_PARTITIONS}/g" $KAFKA_DIR/config/server.properties
sed -i "s/log.segment.bytes=1073741824/log.segment.bytes=${KAFKA_LOG_SEGMENT_BYTES}/g" $KAFKA_DIR/config/server.properties

echo 'enable.zookeeper=false' >> $KAFKA_DIR/config/server.properties
echo "delete.topic.enable=${KAFKA_DELETE_TOPIC_ENABLE}" >> $KAFKA_DIR/config/server.properties
echo "advertised.host.name=${KAFKA_ADVERTISED_HOST_NAME}" >> $KAFKA_DIR/config/server.properties
echo "log.retention.bytes=${KAFKA_LOG_RETENTION_BYTES}" >> $KAFKA_DIR/config/server.properties

ln -s  $KAFKA_LOG4J_DIR $KAFKA_DIR/logs

echo "..configured"
