# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision "shell", path: "main.sh", env: {'VAGRANT'=> 1}

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

  2.times do |i|
    config.vm.define "cassy#{i+1}" do |c|  
        c.vm.hostname = "cassy#{i+1}"
        c.vm.network "private_network", ip: "192.168.60.1#{i+1}"
      
        c.vm.network "forwarded_port", guest: 9160, host: (9260 + i)
        c.vm.network "forwarded_port", guest: 8081, host: (8180 + i)
        c.vm.network "forwarded_port", guest: 9042, host: (9140 + i)
    end
  end
end
