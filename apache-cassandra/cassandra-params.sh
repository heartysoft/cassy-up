echo "exporting variables..."

if [ "x$CASSANDRA_LISTEN_ADDRESS" == "x" ]; then export CASSANDRA_LISTEN_ADDRESS=`hostname -I | awk '{print $NF}'`; fi
if [ "x$CASSANDRA_BROADCAST_ADDRESS" == "x" ]; then export CASSANDRA_BROADCAST_ADDRESS=$CASSANDRA_LISTEN_ADDRESS; fi
if [ "x$CASSANDRA_RPC_ADDRESS" == "x" ]; then export CASSANDRA_RPC_ADDRESS=0.0.0.0; fi
if [ "x$CASSANDRA_BROADCAST_RPC_ADDRESS" == "x" ]; then export CASSANDRA_BROADCAST_RPC_ADDRESS=$CASSANDRA_BROADCAST_ADDRESS; fi

if [ "x$CASSANDRA_VERSION" == "x" ]; then export CASSANDRA_VERSION=3.5; fi
export CASSANDRA_TAR=apache-cassandra-$CASSANDRA_VERSION-bin.tar.gz
if [ "x$CASSANDRA_URL" == "x" ]; then export CASSANDRA_URL=https://www.apache.org/dist/cassandra/$CASSANDRA_VERSION/$CASSANDRA_TAR; fi
if [ "x$CASSANDRA_DOWNLOAD_DIR" == "x" ]; then export CASSANDRA_DOWNLOAD_DIR=/usr/local/downloads/cassandra/cassandra-$CASSANDRA_VERSION; fi
if [ "x$CASSANDRA_ROOT_DIR" == "x" ]; then export CASSANDRA_ROOT_DIR=/opt; fi

export CASSANDRA_DIR=$CASSANDRA_ROOT_DIR/cassandra

export CASSANDRA_INSTALL_DIR=$CASSANDRA_ROOT_DIR/apache-cassandra-$CASSANDRA_VERSION

echo "..using cassandra version: $CASSANDRA_VERSION"
echo "..downloading (if needed) from: $CASSANDRA_URL"
echo "..download dir: $CASSANDRA_DOWNLOAD_DIR"
echo "..install dir: $CASSANDRA_INSTALL_DIR"

if [ "x$CASSANDRA_NUM_TOKENS" == "x" ]; then export CASSANDRA_NUM_TOKENS=256; fi

if [ "x$CASSANDRA_AUTHENTICATOR" == "x" ]; then export CASSANDRA_AUTHENTICATOR=PasswordAuthenticator; fi
if [ "x$CASSANDRA_AUTHORIZER" == "x" ]; then export CASSANDRA_AUTHORIZER=CassandraAuthorizer; fi

