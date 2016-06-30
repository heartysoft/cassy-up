echo "exporting variables..."

if [ "x$SPARK_MASTER_PORT" == "x" ]; then export SPARK_MASTER_PORT=7077; fi
if [ "x$SPARK_VERSION" == "x" ]; then export SPARK_VERSION='1.6.2'; fi

if [ "x$SPARK_MODE" == "x" ]; then echo "SPARK_MODE must be master or worker"; exit 1; fi
if [ "x$SPARK_MASTER_IP" == "x" ]; then echo "SPARK_MASTER_IP is required"; exit 1; fi

if [ "x$SPARK_MASTER" == "x" ]; then export SPARK_MASTER="spark://$SPARK_MASTER_IP:7077"; fi

export SPARK_TAR=spark-$SPARK_VERSION-bin-hadoop1-scala2.11.tgz

if [ "x$SPARK_URL" == "x" ]; then export SPARK_URL=https://www.apache.org/dist/spark/spark-$SPARK_VERSION/$SPARK_TAR; fi
if [ "x$SPARK_DOWNLOAD_DIR" == "x" ]; then export SPARK_DOWNLOAD_DIR=/usr/local/downloads/spark/spark-$SPARK_VERSION; fi
if [ "x$SPARK_ROOT_DIR" == "x" ]; then export SPARK_ROOT_DIR=/opt; fi

if [ "x$SPARK_LOG_DIR" == "x" ]; then export SPARK_LOG_DIR='/var/log/spark'; fi


export SPARK_DIR=$SPARK_ROOT_DIR/spark
export SPARK_INSTALL_DIR=$SPARK_ROOT_DIR/spark-$SPARK_VERSION


echo "..using spark version: $SPARK_VERSION"
echo "..downloading (if needed) from: $SPARK_URL"
echo "..download dir: $SPARK_DOWNLOAD_DIR"
echo "..install dir: $SPARK_INSTALL_DIR"
