
useradd flink || true

mkdir -p $FLINK_DIR/log
chown -R flink $FLINK_LOG_DIR
chown -R flink $FLINK_DIR/log

cp flink.initd /etc/init.d/flink
update-rc.d flink defaults
