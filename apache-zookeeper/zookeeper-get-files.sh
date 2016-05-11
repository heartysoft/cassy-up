# downloads and extracts zookeeper tarball
# if zookeeper-$ZOOKEEPER_VERSION is not present


mkdir -p $ZOOKEEPER_DOWNLOAD_DIR
mkdir -p $ZOOKEEPER_INSTALL_DIR

if [ ! -f "$ZOOKEEPER_DOWNLOAD_DIR/$ZOOKEEPER_TAR" ]; then
    (cd $ZOOKEEPER_DOWNLOAD_DIR && curl -O $ZOOKEEPER_URL)
fi

if [ ! "$(ls -A $ZOOKEEPER_INSTALL_DIR)" ]; then
    echo "extracting $ZOOKEEPER_TAR to $ZOOKEEPER_ROOT_DIR"
    tar -xzf "$ZOOKEEPER_DOWNLOAD_DIR/$ZOOKEEPER_TAR" -C $ZOOKEEPER_ROOT_DIR
    ln -s $ZOOKEEPER_INSTALL_DIR $ZOOKEEPER_DIR
fi
