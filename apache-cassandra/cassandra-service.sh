
useradd cassandra || true

chown -R cassandra /var/lib/cassandra
chown -R cassandra /var/log/cassandra


cp cassandra2.initd /etc/init.d/cassandra
update-rc.d cassandra defaults
