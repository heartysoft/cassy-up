export SCRIPT_ROOT="/vagrant"

#(cd $SCRIPT_ROOT/oracle-jdk && ./main.sh)

#source $SCRIPT_ROOT/apache-cassandra/cassandra-vagrant-params.sh
(cd $SCRIPT_ROOT/apache-zookeeper && ./main.sh)

echo "$HOSTS" > /var/foo
