
export C=$CASSANDRA_DIR/conf

# cassandra.yaml

sed -i "s/cluster_name:.*/cluster_name: '$CASSANDRA_CLUSTER_NAME'/g" $C/cassandra.yaml
sed -i "s/num_tokens:.*/num_tokens: $CASSANDRA_NUM_TOKENS/g" $C/cassandra.yaml
sed -i "s/- seeds:.*/- seeds: \"$CASSANDRA_SEEDS\"/g" $C/cassandra.yaml
sed -i "s/endpoint_snitch:.*/endpoint_snitch: $CASSANDRA_SNITCH/g" $C/cassandra.yaml

sed -i "s/listen_address:.*/listen_address: $CASSANDRA_LISTEN_ADDRESS/g" $C/cassandra.yaml
sed -i "s/# broadcast_address:.*/broadcast_address: $CASSANDRA_BROADCAST_ADDRESS/g" $C/cassandra.yaml
sed -i "s/rpc_address:.*/rpc_address: $CASSANDRA_RPC_ADDRESS/g" $C/cassandra.yaml
sed -i "s/# broadcast_rpc_address:.*/broadcast_rpc_address: $CASSANDRA_BROADCAST_RPC_ADDRESS/g" $C/cassandra.yaml

sed -i "s/authenticator:.*/authenticator: $CASSANDRA_AUTHENTICATOR/g" $C/cassandra.yaml
sed -i "s/authorizer:.*/authorizer: $CASSANDRA_AUTHORIZER/g" $C/cassandra.yaml

sed -i "s/# data_file_directories:.*/data_file_directories:/g" $C/cassandra.yaml
sed -i 's/#\s*- \/var\/lib\/cassandra\/data.*/     - \/var\/lib\/cassandra\/data/g' $C/cassandra.yaml
sed -i 's/# commitlog_directory:.*/commitlog_directory: \/var\/lib\/cassandra\/commitlog/g' $C/cassandra.yaml
sed -i 's/# saved_caches_directory:.*/saved_caches_directory: \/var\/lib\/cassandra\/saved_caches/g' $C/cassandra.yaml
sed -i 's/# hints_directory:.*/hints_directory: \/var\/lib\/cassandra\/hints/g' $C/cassandra.yaml
sed -i 's/${cassandra.logdir}/\/var\/log\/cassandra/g' $C/logback.xml

mkdir -p /var/lib/cassandra/data
mkdir -p /var/lib/cassandra/commitlog
mkdir -p /var/lib/cassandra/saved_caches
mkdir -p /var/lib/cassandra/hints
mkdir -p /var/log/cassandra

# cassandra-rackdc.properties

if [ "x$CASSANDRA_SNITCH" == "xGossipingPropertyFileSnitch" ] 
then
        sed -i "s/dc=.*/dc=$CASSANDRA_DC/g" $C/cassandra-rackdc.properties
        sed -i "s/rack=.*/rack=$CASSANDRA_RACK/g" $C/cassandra-rackdc.properties
fi

if [ "x$CASSANDRA_SNITCH" == "xEc2Snitch" ] || [ "x$CASSANDRA_SNITCH" == "xEc2MultiRegionSnitch" ]
then
        sed -i "s/dc=.*/#dc=dc1/g" $C/cassandra-rackdc.properties
        sed -i "s/rack=.*/#rack=rack1/g" $C/cassandra-rackdc.properties
        sed -i "s/#dc_suffix=.*/dc_suffix=$CASSANDRA_DC_SUFFIX/g" $C/cassandra-rackdc.properties
fi

touch /etc/profile.d/cassandra.sh
printf '%s\n%s\n' "export CASSANDRA_HOME=$CASSANDRA_DIR/" 'export PATH=$PATH:$CASSANDRA_HOME/bin/:$CASSANDRA_HOME/tools/bin/\n' >> /etc/profile.d/cassandra.sh
printf '%s\n' "source /etc/profile.d/cassandra.sh" >> /etc/bash.bashrc

