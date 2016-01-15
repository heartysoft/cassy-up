
if [ "x$CASSANDRA_CLUSTER_NAME" == "x" ]; then export CASSANDRA_CLUSTER_NAME="dev"; fi
if [ "x$CASSANDRA_SEEDS" == "x" ]; then export CASSANDRA_SEEDS="192.168.60.11"; fi

if [ "x$CASSANDRA_SNITCH" == "x" ]; then export CASSANDRA_SNITCH="GossipingPropertyFileSnitch"; fi
if [ "x$CASSANDRA_DC" == "x" ]; then export CASSANDRA_DC="dev1"; fi
if [ "x$CASSANDRA_RACK" == "x" ]; then export CASSANDRA_RACK="rack1"; fi
if [ "x$CASSANDRA_DC_SUFFIX" == "x" ]; then export CASSANDRA_DC_SUFFIX="_dev_cassandra"; fi


if [ "x$CASSANDRA_LISTEN_ADDRESS" == "x" ]; then export CASSANDRA_LISTEN_ADDRESS=`hostname -I | awk '{print $NF}'`; fi
if [ "x$CASSANDRA_BROADCAST_ADDRESS" == "x" ]; then export CASSANDRA_BROADCAST_ADDRESS=$CASSANDRA_LISTEN_ADDRESS; fi
if [ "x$CASSANDRA_RPC_ADDRESS" == "x" ]; then export CASSANDRA_RPC_ADDRESS=$CASSANDRA_LISTEN_ADDRESS; fi
