#!/usr/bin/env bash

echo "configuring DSE Cassandra..."

export CONFIG_DIR=/etc/dse/cassandra

# /etc/default/dse

sed -i "s/SOLR_ENABLED=0/SOLR_ENABLED=1/g" /etc/default/dse

# cassandra.yaml

sed -i "s/cluster_name:.*/cluster_name: '$CASSANDRA_CLUSTER_NAME'/g" $CONFIG_DIR/cassandra.yaml
sed -i "s/num_tokens:.*/num_tokens: $CASSANDRA_NUM_TOKENS/g" $CONFIG_DIR/cassandra.yaml
sed -i "s/- seeds:.*/- seeds: \"$CASSANDRA_SEEDS\"/g" $CONFIG_DIR/cassandra.yaml
sed -i "s/endpoint_snitch:.*/endpoint_snitch: $CASSANDRA_SNITCH/g" $CONFIG_DIR/cassandra.yaml

sed -i "s/listen_address:.*/listen_address: $CASSANDRA_LISTEN_ADDRESS/g" $CONFIG_DIR/cassandra.yaml
sed -i "s/# broadcast_address:.*/broadcast_address: $CASSANDRA_BROADCAST_ADDRESS/g" $CONFIG_DIR/cassandra.yaml
sed -i "s/rpc_address:.*/rpc_address: $CASSANDRA_RPC_ADDRESS/g" $CONFIG_DIR/cassandra.yaml
sed -i "s/.*broadcast_rpc_address:.*/broadcast_rpc_address: $CASSANDRA_BROADCAST_RPC_ADDRESS/g" $CONFIG_DIR/cassandra.yaml
sed -i "s/start_rpc:.*/start_rpc: true/g" $CONFIG_DIR/cassandra.yaml

sed -i "s/authenticator:.*/authenticator: $CASSANDRA_AUTHENTICATOR/g" $CONFIG_DIR/cassandra.yaml
sed -i "s/authorizer:.*/authorizer: $CASSANDRA_AUTHORIZER/g" $CONFIG_DIR/cassandra.yaml

sed -i "s/# data_file_directories:.*/data_file_directories:/g" $CONFIG_DIR/cassandra.yaml
sed -i 's/#\s*- \/var\/lib\/cassandra\/data.*/     - \/var\/lib\/cassandra\/data/g' $CONFIG_DIR/cassandra.yaml
sed -i 's/# commitlog_directory:.*/commitlog_directory: \/var\/lib\/cassandra\/commitlog/g' $CONFIG_DIR/cassandra.yaml
sed -i 's/# saved_caches_directory:.*/saved_caches_directory: \/var\/lib\/cassandra\/saved_caches/g' $CONFIG_DIR/cassandra.yaml
sed -i 's/# hints_directory:.*/hints_directory: \/var\/lib\/cassandra\/hints/g' $CONFIG_DIR/cassandra.yaml
sed -i 's/${cassandra.logdir}/\/var\/log\/cassandra/g' $CONFIG_DIR/logback.xml

# cassandra-rackdc.properties

if [ "x$CASSANDRA_SNITCH" == "xGossipingPropertyFileSnitch" ]
then
        sed -i "s/dc=.*/dc=$CASSANDRA_DC/g" $CONFIG_DIR/cassandra-rackdc.properties
        sed -i "s/rack=.*/rack=$CASSANDRA_RACK/g" $CONFIG_DIR/cassandra-rackdc.properties
fi

if [ "x$CASSANDRA_SNITCH" == "xEc2Snitch" ] || [ "x$CASSANDRA_SNITCH" == "xEc2MultiRegionSnitch" ]
then
        sed -i "s/dc=.*/#dc=dc1/g" $CONFIG_DIR/cassandra-rackdc.properties
        sed -i "s/rack=.*/#rack=rack1/g" $CONFIG_DIR/cassandra-rackdc.properties
        sed -i "s/#dc_suffix=.*/dc_suffix=$CASSANDRA_DC_SUFFIX/g" $CONFIG_DIR/cassandra-rackdc.properties
fi

# cassandra-env.sh

if [ "x$CASSANDRA_CONSISTENT_RANGEMOVEMENT" == "x0" ]; then
  echo 'JVM_OPTS="$JVM_OPTS -Dcassandra.consistent.rangemovement=false"' >> $CONFIG_DIR/cassandra-env.sh
fi

echo "..configured"
