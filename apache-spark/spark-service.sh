
useradd -r spark || true

#chown -R spark /var/lib/spark || true
chown -R spark /var/log/spark || true


cp spark-master.initd /etc/init.d/spark
update-rc.d spark defaults
