#!/bin/bash
export SCRIPT_ROOT="/vagrant"

source $SCRIPT_ROOT/apache-flink/flink-params.sh

echo "uninstalling flink..."

service flink stop || true

rm -rf $FLINK_DIR || true
rm -rf $FLINK_INSTALL_DIR || true
rm /etc/init.d/flink || true
rm /etc/profile.d/flink.sh

echo "..uninstalled flink"
