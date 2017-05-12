#!/usr/bin/env bash
echo "exporting variables..."

if [ "x$CASSANDRA_LISTEN_ADDRESS" == "x" ]; then export CASSANDRA_LISTEN_ADDRESS=`hostname -I | awk '{print $NF}'`; fi
if [ "x$CASSANDRA_BROADCAST_ADDRESS" == "x" ]; then export CASSANDRA_BROADCAST_ADDRESS=$CASSANDRA_LISTEN_ADDRESS; fi
if [ "x$CASSANDRA_RPC_ADDRESS" == "x" ]; then export CASSANDRA_RPC_ADDRESS=0.0.0.0; fi
if [ "x$CASSANDRA_BROADCAST_RPC_ADDRESS" == "x" ]; then export CASSANDRA_BROADCAST_RPC_ADDRESS=$CASSANDRA_BROADCAST_ADDRESS; fi

if [ "x$CASSANDRA_NUM_TOKENS" == "x" ]; then export CASSANDRA_NUM_TOKENS=256; fi

if [ "x$CASSANDRA_AUTHENTICATOR" == "x" ]; then export CASSANDRA_AUTHENTICATOR=PasswordAuthenticator; fi
if [ "x$CASSANDRA_AUTHORIZER" == "x" ]; then export CASSANDRA_AUTHORIZER=CassandraAuthorizer; fi
