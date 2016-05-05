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
  kafka_nodes = 2
  hostnames = (1..kafka_nodes).map {|i| "kafka-#{i}"}.join(',')

  kafka_nodes.times do |i|
    config.vm.define "kafka-#{i+1}" do |c|
        c.vm.provision "shell", path: "kafka.sh", env: {'VAGRANT'=> 1, 'HOSTS' => hostnames}

        c.vm.provider "virtualbox" do |vb|
          vb.memory = 1024
          vb.cpus = 2
        end

        c.vm.hostname = "kafka-#{i+1}"
        c.vm.network "private_network", ip: "192.168.70.1#{i+1}"

        c.vm.network "forwarded_port", guest: 2181, host: (2180 + i)
        #c.vm.network "forwarded_port", guest: 8081, host: (8180 + i)
        #c.vm.network "forwarded_port", guest: 9042, host: (9140 + i)
    end
  end

end
