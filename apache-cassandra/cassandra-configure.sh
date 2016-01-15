
export C=$CASSANDRA_DIR/conf

# cassandra.yaml

sed -i "s/cluster_name:.*/cluster_name: '$CASSANDRA_CLUSTER_NAME'/g" $C/cassandra.yaml
sed -i "s/num_tokens:.*/num_tokens: $CASSANDRA_NUM_TOKENS/g" $C/cassandra.yaml
sed -i "s/- seeds:.*/- seeds: \"$CASSANDRA_SEEDS\"/g" $C/cassandra.yaml
sed -i "s/endpoint_snitch:.*/endpoint_snitch: $CASSANDRA_SNITCH/g" $C/cassandra.yaml

sed -i "s/listen_address:.*/listen_address: $CASSANDRA_LISTEN_ADDRESS/g" $C/cassandra.yaml
sed -i "s/# broadcast_address:.*/broadcast_address: $CASSANDRA_BROADCAST_ADDRESS/g" $C/cassandra.yaml
sed -i "s/rpc_address:.*/rpc_address: $CASSANDRA_RPC_ADDRESS/g" $C/cassandra.yaml

sed -i "s/authenticator:.*/authenticator: $CASSANDRA_AUTHENTICATOR/g" $C/cassandra.yaml
sed -i "s/authorizer:.*/authorizer: $CASSANDRA_AUTHORIZER/g" $C/cassandra.yaml



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



