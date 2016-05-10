# configures kafka

echo "configuring kafka..."

mkdir -p $KAFKA_DATA_DIR
mkdir -p $KAFKA_LOG_DIR

sed -i "s/broker.id=0/broker.id=${BROKER_NAME}/g" $KAFKA_DIR/config/server.properties
sed -i "s@/tmp/kafka-logs@${KAFKA_LOG_DIR}@g" $KAFKA_DIR/config/server.properties
sed -i "s/localhost:2181/${ZOO_HOSTS}/g" $KAFKA_DIR/config/server.properties
echo 'enable.zookeeper=false' >> $KAFKA_DIR/config/server.properties

echo "..configured"
