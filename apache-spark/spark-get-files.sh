# downloads and extracts spark tarball
# if spark-$SPARK_VERSION is not present


mkdir -p $SPARK_DOWNLOAD_DIR
mkdir -p $SPARK_INSTALL_DIR 
mkdir -p $SPARK_LOG_DIR

if [ ! -f "$SPARK_DOWNLOAD_DIR/$SPARK_TAR" ]; then
    (cd $SPARK_DOWNLOAD_DIR && wget $SPARK_URL)
fi

if [ ! "$(ls -A $SPARK_INSTALL_DIR)" ]; then
    rm -rf $SPARK_INSTALL_DIR 
    echo "extracting $SPARK_TAR to $SPARK_ROOT_DIR"
    tar -xzf "$SPARK_DOWNLOAD_DIR/$SPARK_TAR" -C $SPARK_ROOT_DIR
    mv $SPARK_INSTALL_DIR-* $SPARK_INSTALL_DIR
fi

ln -sfn $SPARK_INSTALL_DIR $SPARK_DIR || true
