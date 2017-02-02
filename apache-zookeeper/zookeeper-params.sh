if [ "x$ZOOKEEPER_MY_ID" == "x" ]; then 
	echo "ZOOKEEPER_MY_ID must be specified"
	exit 1
fi

echo "exporting variables..."
if [ "x$ZOOKEEPER_VERSION" == "x" ]; then export ZOOKEEPER_VERSION=3.4.8; fi
export ZOOKEEPER_TAR=zookeeper-$ZOOKEEPER_VERSION.tar.gz
if [ "x$ZOOKEEPER_URL" == "x" ]; then export ZOOKEEPER_URL=https://www.apache.org/dist/zookeeper/zookeeper-$ZOOKEEPER_VERSION/$ZOOKEEPER_TAR; fi
if [ "x$ZOOKEEPER_DOWNLOAD_DIR" == "x" ]; then export ZOOKEEPER_DOWNLOAD_DIR=/usr/local/downloads/zookeeper/zookeeper-$ZOOKEEPER_VERSION; fi
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
