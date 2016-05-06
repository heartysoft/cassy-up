# configures zookeeper

echo "configuring zookeeper..."

mkdir -p $ZOOKEEPER_DATA_DIR
mkdir -p $ZOOKEEPER_LOG_DIR

echo "tickTime=2000" >> $ZOOKEEPER_DIR/conf/zoo.cfg
echo "dataDir=$ZOOKEEPER_DATA_DIR" >> $ZOOKEEPER_DIR/conf/zoo.cfg
echo "clientPort=2181" >> $ZOOKEEPER_DIR/conf/zoo.cfg
echo "initLimit=5" >> $ZOOKEEPER_DIR/conf/zoo.cfg
echo "syncLimit=2" >> $ZOOKEEPER_DIR/conf/zoo.cfg

IFS=',' read -r -a HOSTSARR <<< "$HOSTS"
for index in "${!HOSTSARR[@]}"
do
    echo "server.$((index+1))=${HOSTSARR[index]}:2888:3888" >> $ZOOKEEPER_DIR/conf/zoo.cfg
done

echo "ZOO_"
sed -i "1iZOO_LOG_DIR=$ZOOKEEPER_LOG_DIR" $ZOOKEEPER_DIR/bin/zkEnv.sh

echo $ZOOKEEPER_MY_ID >> $ZOOKEEPER_DATA_DIR/myid

echo "..configured"
