echo "exporting vagrant specific default parameters..."

if [ "x$KAFKA_DOWNLOAD_DIR" == "x" ]; then export KAFKA_DOWNLOAD_DIR=/vagrant/files/downloads/apache-kafka; fi

echo ".. download dir: $KAFKA_DOWNLOAD_DIR"

