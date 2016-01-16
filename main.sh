export SCRIPT_ROOT="/vagrant"

(cd $SCRIPT_ROOT/oracle-jdk && ./main.sh)
(cd $SCRIPT_ROOT/apache-cassandra && ./main.sh)

echo "all done. bye bye."

