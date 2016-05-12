# cassy-up
Simpler bash scripts for spinning up Cassandra, Kafka, Zookeeper, etc. from tarballs

# Usage

Entry point for different products are in environments/[environment-name]/script.sh

For use in vagrant, use a shell provisioner, and pass in required environment params. Check the vagrant file for examples.

For use in AWS, copy the product folder (e.g. apache-zookeeper), and the relevant entry point script (e.g. environments/aws/zookeeper.sh), chmod, and run the entry point script. Check the entry point script to see if some additional file setting up some environment params is needed or not. Use of terraform is highly recommended for this.

