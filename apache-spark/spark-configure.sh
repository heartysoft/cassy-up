
echo '#!/bin/bash' > $SPARK_DIR/conf/spark-env.sh

if [ $SPARK_MODE == "master" ]; then
   master_ip=`hostname -I | awk '{print $NF}'`
   echo "export SPARK_MASTER_IP=$master_ip" >> $SPARK_DIR/conf/spark-env.sh
else 
  if [ "x$SPARK_MAX_WORKER_CORES" -ne "x"]; then
    echo "export SPARK_WORKER_CORES=$SPARK_MAX_WORKER_CORES" >> $SPARK_DIR/conf/spark-env.sh
  fi 

  if [ "x$SPARK_MAX_WORKER_RAM" -ne "x"]; then
    echo "export SPARK_WORKER_MEMORY=$SPARK_MAX_WORKER_RAM" >> $SPARK_DIR/conf/spark-env.sh
  fi 
fi

echo "export SPARK_LOG_DIR=/var/log/spark" >> $SPARK_DIR/conf/spark-env.sh
