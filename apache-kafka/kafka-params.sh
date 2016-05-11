echo "exporting variables..."
if [ "x$SCALA_VERSION" == "x" ]; then export SCALA_VERSION=2.11; fi
if [ "x$KAFKA_VERSION" == "x" ]; then export KAFKA_VERSION=0.9.0.1; fi
export KAFKA_TAR=kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz
if [ "x$KAFKA_URL" == "x" ]; then export KAFKA_URL=https://www.apache.org/dist/kafka/$KAFKA_VERSION/$KAFKA_TAR; fi
if [ "x$KAFKA_DOWNLOAD_DIR" == "x" ]; then export KAFKA_DOWNLOAD_DIR=/usr/local/downloads/kafka/kafka-$KAFKA_VERSION; fi
if [ "x$KAFKA_ROOT_DIR" == "x" ]; then export KAFKA_ROOT_DIR=/opt; fi
if [ "x$KAFKA_DATA_DIR" == "x" ]; then export KAFKA_DATA_DIR=/var/lib/kafka; fi
if [ "x$KAFKA_LOG_DIR" == "x" ]; then export KAFKA_LOG_DIR=/var/lib/kafka; fi
if [ "x$KAFKA_LOG4J_DIR" == "x" ]; then export KAFKA_LOG4J_DIR=/var/log/kafka; fi
if [ "x$KAFKA_HEAP_OPTS" == "x" ]; then export KAFKA_HEAP_OPTS="-Xmx2G -Xms2G"; fi
if [ "x$KAFKA_ADVERTISED_HOST_NAME" == "x" ]; then export KAFKA_ADVERTISED_HOST_NAME="`hostname`"; fi

export KAFKA_DIR=$KAFKA_ROOT_DIR/kafka
export KAFKA_INSTALL_DIR=$KAFKA_ROOT_DIR/kafka_$SCALA_VERSION-$KAFKA_VERSION

echo "..using kafka version: $KAFKA_VERSION"
echo "..downloading from (if needed): $KAFKA_URL"
echo ".. download dir: $KAFKA_DOWNLOAD_DIR"
echo "..install dir: $KAFKA_INSTALL_DIR"
echo "..data directory: $KAFKA_DATA_DIR"
