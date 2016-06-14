#!/usr/bin/env bash

useradd -r cassandra || true

chown -R cassandra /var/lib/cassandra
chown -R cassandra /var/log/cassandra


cp cassandra.initd /etc/init.d/cassandra
update-rc.d cassandra defaults
