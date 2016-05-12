# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  #spark master

  #cassandra + spark workers
  #  2.times do |i|
  #   config.vm.define "cassy#{i+1}" do |c|
  #       c.vm.provision "shell", path: "main.sh", env: {'VAGRANT'=> 1}
  #
  #       c.vm.provider "virtualbox" do |vb|
  #         vb.memory = 2048
  #         vb.cpus = 2
  #       end
  #
  #       c.vm.hostname = "cassy#{i+1}"
  #       c.vm.network "private_network", ip: "192.168.60.1#{i+1}"
  #
  #       c.vm.network "forwarded_port", guest: 9160, host: (9260 + i)
  #       c.vm.network "forwarded_port", guest: 8081, host: (8180 + i)
  #       c.vm.network "forwarded_port", guest: 9042, host: (9140 + i)
  #   end
  # end

  #zookeeper + kafka (3 nodes)
  zookeeper_nodes = 3
  zookeeper_base_ip = "192.168.70.1"
  zookeeper_host_ips = (1..zookeeper_nodes).map {|i| "#{zookeeper_base_ip}#{i}"}.join(',')
  
  
  # (1..zookeeper_nodes).each do |i|
  #   config.vm.define "zookeeper-#{i}" do |c|

  #       c.vm.provision "shell", path: "environments/vagrant/oracle-jdk.sh"
  #       c.vm.provision "shell", path: "environments/vagrant/zookeeper.sh", env: {'ZOOKEEPER_SERVERS' => zookeeper_host_ips, 'ZOOKEEPER_MY_ID' => i}
        
  #       c.vm.provider "virtualbox" do |vb|
  #           vb.memory = 1024
  #           vb.cpus = 2
  #       end

  #       c.vm.hostname = "zookeeper-#{i}"
  #       c.vm.network "private_network", ip: "#{zookeeper_base_ip}#{i}"

  #       c.vm.network "forwarded_port", guest: 2181, host: (2180 + i)
  #   end
  # end


  kafka_nodes = 3
  kafka_base_ip = "192.168.70.2"
  kafka_host_ips = (1..kafka_nodes).map {|i| "#{kafka_base_ip}#{i}"}.join(',')
  

  (1..kafka_nodes).each do |i|
    config.vm.define "kafka-#{i}" do |c|
        c.vm.provision "shell", path: "environments/vagrant/oracle-jdk.sh"
        c.vm.provision "shell", path: "environments/vagrant/kafka.sh", env: {'KAFKA_ZOOKEEPER_SERVERS' => zookeeper_host_ips, 'KAFKA_BROKER_NAME' => i}

        c.vm.provider "virtualbox" do |vb|
            vb.memory = 1024
            vb.cpus = 2
        end

        c.vm.hostname = "kafka-#{i}"
        c.vm.network "private_network", ip: "#{kafka_base_ip}#{i}"
        c.vm.network "forwarded_port", guest: 9092, host: (9091 + i)
    end
  end
  
end
