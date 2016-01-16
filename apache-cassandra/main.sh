source ./cassandra-params.sh

if [ "x$VAGRANT" == "x1" ]; then source ./cassandra-vagrant-params.sh; fi

./cassandra-get-files.sh
./cassandra-configure.sh
./cassandra-service.sh

service cassandra start


