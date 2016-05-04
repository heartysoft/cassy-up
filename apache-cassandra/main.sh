source ./cassandra-params.sh

./cassandra-get-files.sh
./cassandra-configure.sh
./cassandra-service.sh

service cassandra start


