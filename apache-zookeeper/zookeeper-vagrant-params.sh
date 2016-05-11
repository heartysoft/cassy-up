echo "exporting vagrant specific default parameters..."

if [ "x$ZOOKEEPER_DOWNLOAD_DIR" == "x" ]; then export ZOOKEEPER_DOWNLOAD_DIR=/vagrant/files/downloads/apache-zookeeper; fi
if [ "x$ZOOKEEPER_ROOT_DIR" == "x" ]; then export ZOOKEEPER_ROOT_DIR=/opt; fi
if [ "x$ZOOKEEPER_DATA_DIR" == "x" ]; then export ZOOKEEPER_DATA_DIR=/var/lib/zookeeper; fi
if [ "x$ZOOKEEPER_LOG_DIR" == "x" ]; then export ZOOKEEPER_LOG_DIR=/var/log/zookeeper; fi

export ZOOKEEPER_DIR=$ZOOKEEPER_ROOT_DIR/zookeeper
export ZOOKEEPER_INSTALL_DIR="$ZOOKEEPER_DIR-$ZOOKEEPER_VERSION"

echo "..using zookeeper version: $ZOOKEEPER_VERSION"
echo "..downloading from (if needed): $ZOOKEEPER_URL"
echo ".. download dir: $ZOOKEEPER_DOWNLOAD_DIR"
echo "..install dir: $ZOOKEEPER_INSTALL_DIR"
echo "..data directory: $ZOOKEEPER_DATA_DIR"
