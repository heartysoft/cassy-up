# downloads and extracts kafka tarball
# if not present already


mkdir -p $KAFKA_DOWNLOAD_DIR
mkdir -p $KAFKA_INSTALL_DIR

if [ ! -f "$KAFKA_DOWNLOAD_DIR/$KAFKA_TAR" ]; then
    (cd $KAFKA_DOWNLOAD_DIR && curl -O $KAFKA_URL)
fi

if [ ! "$(ls -A $KAFKA_INSTALL_DIR)" ]; then
    echo "extracting $KAFKA_TAR to $KAFKA_ROOT_DIR"
    tar -xzf "$KAFKA_DOWNLOAD_DIR/$KAFKA_TAR" -C $KAFKA_ROOT_DIR
    ln -s $KAFKA_INSTALL_DIR $KAFKA_DIR
fi