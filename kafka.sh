export SCRIPT_ROOT="/vagrant"

#(cd $SCRIPT_ROOT/oracle-jdk && ./main.sh)

source $SCRIPT_ROOT/apache-kafka/kafka-vagrant-params.sh
(cd $SCRIPT_ROOT/apache-kafka && ./main.sh)
