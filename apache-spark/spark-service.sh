
useradd -r spark || true

#chown -R spark /var/lib/spark || true
chown -R spark /var/log/spark || true
chown -R spark $SPARK_DIR/work || true

if [ $SPARK_MODE == "master" ]; then
  cp spark-master.initd /etc/init.d/spark
else 
  cp spark-worker.initd /etc/init.d/spark
fi

update-rc.d spark defaults
