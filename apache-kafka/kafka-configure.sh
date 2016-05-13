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
echo 'enable.zookeeper=false' >> $KAFKA_DIR/config/server.properties
echo "advertised.host.name=${KAFKA_ADVERTISED_HOST_NAME}" >> $KAFKA_DIR/config/server.properties

ln -s  $KAFKA_LOG4J_DIR $KAFKA_DIR/logs

echo "..configured"
