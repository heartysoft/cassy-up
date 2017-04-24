#/bin/bash
echo "installing jdk 8.........................."
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get -y install oracle-java8-installer
apt-get -y install oracle-java8-set-default
echo "..........................jdk 8 installed."
apt-get -y install libjna-java
echo "..........................jna setup complete."

