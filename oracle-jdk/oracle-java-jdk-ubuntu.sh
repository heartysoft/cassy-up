#/bin/bash
echo "installing jdk 8.........................."
add-apt-repository ppa:webupd8team/java
apt-get update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get install oracle-java8-installer -y
apt-get install oracle-java8-set-default -y
echo "..........................jdk 8 installed."
apt-get install libjna-java
echo "..........................jna setup complete."

