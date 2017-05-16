#!/usr/bin/env bash

read -d '' DATASTAX_REPO <<- EOF
[datastax]
name = DataStax Repo for DataStax Enterprise
baseurl=https://${DATASTAX_EMAIL}:${DATASTAX_PASSWORD}@rpm.datastax.com/enterprise
enabled=1
gpgcheck=0
EOF

echo "$DATASTAX_REPO" > /etc/yum.repos.d/datastax.repo

yum -y erase java-1.7.0-openjdk
yum -y install java-1.8.0-openjdk dse-full-${DATASTAX_VERSION}-1
