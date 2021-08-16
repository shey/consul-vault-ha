# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'ubuntu/focal64'

  # requires vagrant-hostmanager
  config.hostmanager.manage_host = false
  config.hostmanager.manage_guest = true

  config.ssh.insert_key = true
  config.ssh.forward_agent = true

  ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip

  config.vm.provision "shell", inline: <<-SHELL
    echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
    echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
    sudo apt -qq install python-is-python3
  SHELL

  # General VirtualBox VM configuration.
  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--cpus", 1]
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.define "consul01" do |consul01|
    consul01.vm.hostname = "consul01"
    consul01.vm.network :private_network, ip: "10.128.32.101"
  end

  config.vm.define "consul02" do |consul02|
    consul02.vm.hostname = "consul02"
    consul02.vm.network :private_network, ip: "10.128.32.102"
  end

  config.vm.define "consul03" do |consul03|
    consul03.vm.hostname = "consul03"
    consul03.vm.network :private_network, ip: "10.128.32.103"
  end

  config.vm.define "proxy01" do |proxy01|
    proxy01.vm.hostname = "proxy01"
    proxy01.vm.network :private_network, ip: "10.128.33.100"
  end

  config.vm.define "vault01" do |vault01|
    vault01.vm.hostname = "vault01"
    vault01.vm.network :private_network, ip: "10.128.33.101"
  end

  config.vm.define "vault02" do |vault02|
    vault02.vm.hostname = "vault02"
    vault02.vm.network :private_network, ip: "10.128.33.102"
  end

end
