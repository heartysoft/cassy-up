# downloads and extracts cassandra tarball
# if cassandra-$CASSANDRA_VERSION is not present


mkdir -p $CASSANDRA_DOWNLOAD_DIR
mkdir -p $CASSANDRA_INSTALL_DIR

if [ ! -f "$CASSANDRA_DOWNLOAD_DIR/$CASSANDRA_TAR" ]; then
    (cd $CASSANDRA_DOWNLOAD_DIR && curl -O $CASSANDRA_URL)
fi

if [ ! "$(ls -A $CASSANDRA_INSTALL_DIR)" ]; then
    echo "extracting $CASSANDRA_TAR to $CASSANDRA_ROOT_DIR"
    tar -xzf "$CASSANDRA_DOWNLOAD_DIR/$CASSANDRA_TAR" -C $CASSANDRA_ROOT_DIR
fi

ln -sfn $CASSANDRA_INSTALL_DIR $CASSANDRA_DIR || true
