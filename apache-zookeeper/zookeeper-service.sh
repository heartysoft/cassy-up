
useradd zookeeper || true

chown -R zookeeper $ZOOKEEPER_DATA_DIR
chown -R zookeeper $ZOOKEEPER_LOG_DIR


cp zookeeper.initd /etc/init.d/zookeeper
update-rc.d zookeeper defaults
