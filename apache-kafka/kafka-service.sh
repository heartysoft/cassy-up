useradd kafka || true

chown -R kafka $KAFKA_DATA_DIR
chown -R kafka $KAFKA_LOG_DIR
chown -R kafka $KAFKA_LOG4J_DIR

cp kafka.initd /etc/init.d/kafka
update-rc.d kafka defaults