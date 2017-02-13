#!/usr/bin/env bash

useradd -r cassandra || true

chown -R cassandra /var/lib/cassandra
chown -R cassandra /var/log/cassandra

if [[ "$CASSANDRA_SYSTEMD" -eq 1 ]]; then
  cp cassandra.service /etc/systemd/system/
  sed -i "s@{{cassandra_dir}}@${CASSANDRA_DIR}@" /etc/systemd/system/cassandra.service
  systemctl daemon-reload
  systemctl enable cassandra.service
else
  cp cassandra.initd /etc/init.d/cassandra
  update-rc.d cassandra defaults
fi
