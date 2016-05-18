
echo "exporting variables..."
if [ "x$FLINK_VERSION" == "x" ]; then export FLINK_VERSION=1.0.3; fi
if [ "x$FLINK_HADOOP_VERSION" == "x" ]; then export FLINK_HADOOP_VERSION=27; fi
if [ "x$FLINK_SCALA_VERSION" == "x" ]; then export FLINK_SCALA_VERSION=2.11; fi

export FLINK_TAR=flink-$FLINK_VERSION-bin-hadoop$FLINK_HADOOP_VERSION-scala_$FLINK_SCALA_VERSION.tgz

if [ "x$FLINK_URL" == "x" ]; then export FLINK_URL=https://www.apache.org/dist/flink/flink-$FLINK_VERSION/$FLINK_TAR; fi
if [ "x$FLINK_DOWNLOAD_DIR" == "x" ]; then export FLINK_DOWNLOAD_DIR=/usr/local/downloads/flink/flink-$FLINK_VERSION; fi
if [ "x$FLINK_ROOT_DIR" == "x" ]; then export FLINK_ROOT_DIR=/opt; fi
if [ "x$FLINK_LOG_DIR" == "x" ]; then export FLINK_LOG_DIR=/var/log/flink; fi

if [ "x$FLINK_JOBMANAGER_HEAP" == "x" ]; then export FLINK_JOBMANAGER_HEAP=256; fi
if [ "x$FLINK_TASKMANAGER_HEAP" == "x" ]; then export FLINK_TASKMANAGER_HEAP=512; fi

export FLINK_DIR=$FLINK_ROOT_DIR/flink
export FLINK_INSTALL_DIR="$FLINK_DIR-$FLINK_VERSION"

echo "..using flink version: $FLINK_VERSION"
echo "..downloading from (if needed): $FLINK_URL"
echo ".. download dir: $FLINK_DOWNLOAD_DIR"
echo "..install dir: $FLINK_INSTALL_DIR"
