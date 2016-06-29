
echo '#!/bin/bash' > $SPARK_DIR/conf/spark-env.sh
echo "export SPARK_MASTER_IP=$SPARK_MASTER_IP" >> $SPARK_DIR/conf/spark-env.sh
echo "export SPARK_MASTER=$SPARK_MASTER" >> $SPARK_DIR/conf/spark-env.sh

if [ "x$SPARK_LOCAL_IP" != "x" ]; then 
  echo "export SPARK_LOCAL_IP=$SPARK_LOCAL_IP" >> $SPARK_DIR/conf/spark-env.sh
fi

if [ $SPARK_MODE == "master" ]; then
  echo "No master specific configuration used."   
else 
  if [ "x$SPARK_MAX_WORKER_CORES" != "x" ]; then
    echo "export SPARK_WORKER_CORES=$SPARK_MAX_WORKER_CORES" >> $SPARK_DIR/conf/spark-env.sh
  fi 

  if [ "x$SPARK_MAX_WORKER_RAM" != "x" ]; then
    echo "export SPARK_WORKER_MEMORY=$SPARK_MAX_WORKER_RAM" >> $SPARK_DIR/conf/spark-env.sh
  fi 
fi

echo "export SPARK_LOG_DIR=/var/log/spark" >> $SPARK_DIR/conf/spark-env.sh
