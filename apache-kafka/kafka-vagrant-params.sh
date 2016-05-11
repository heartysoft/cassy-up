echo "exporting vagrant specific default parameters..."

if [ "x$KAFKA_DOWNLOAD_DIR" == "x" ]; then export KAFKA_DOWNLOAD_DIR=/vagrant/files/downloads/apache-kafka; fi
if [ "x$KAFKA_HEAP_OPTS" == "x" ]; then export KAFKA_HEAP_OPTS="-Xmx256M -Xms256M"; fi

echo ".. download dir: $KAFKA_DOWNLOAD_DIR"

