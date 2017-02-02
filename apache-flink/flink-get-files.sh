# downloads and extracts flink tarball
# if it's not present

mkdir -p $FLINK_DOWNLOAD_DIR
mkdir -p $FLINK_INSTALL_DIR

if [ ! -f "$FLINK_DOWNLOAD_DIR/$FLINK_TAR" ]; then
    (cd $FLINK_DOWNLOAD_DIR && curl -O $FLINK_URL)
fi

if [ ! "$(ls -A $FLINK_INSTALL_DIR)" ]; then
    echo "extracting $FLINK_TAR to $FLINK_ROOT_DIR"
    tar -xzf "$FLINK_DOWNLOAD_DIR/$FLINK_TAR" -C $FLINK_ROOT_DIR
fi

ln -sfn $FLINK_INSTALL_DIR $FLINK_DIR || true
