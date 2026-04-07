# -*- mode: ruby -*-
# vi: set ft=ruby :
require_relative 'provisioning/vbox.rb'
VBoxUtils.check_version('7.2.4')
Vagrant.require_version ">= 2.4.9"

CLIENT_HOSTNAME = "X-client"
# DO NOT change the OMV hostname
OMV_HOSTNAME = "omv-server"

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  
  # Configure hostmanager plugin
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true

  config.vm.define "omv-server", primary: true do |omv|
    omv.vm.box = "rreye/omv8"
    omv.vm.box_version = "1.0"
    omv.vm.box_check_update = false
    omv.vm.hostname = OMV_HOSTNAME
    omv.vm.network "forwarded_port", guest: 80, host: 9090
    omv.vm.network "private_network", ip: "192.172.16.25", virtualbox__intnet: "omv"

    for i in 0..2 do
        omv.vm.disk :disk, size: "10GB", primary: false, name: "disk#{i}"
    end
    
    omv.vm.provider "virtualbox" do |vb|
      vb.name = "AISI-P5-OMV"
      vb.cpus = 2
      vb.memory = 2048
      vb.gui = false
      vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    end
  end

  config.vm.define "client" do |client|
    client.vm.box = "rreye/debian-13-gui"
    client.vm.box_version = "20260407"
    client.vm.box_check_update = false
    client.vm.hostname = CLIENT_HOSTNAME
    client.vm.network "private_network", ip: "192.172.16.30", virtualbox__intnet: "omv"

    client.vm.provider "virtualbox" do |vb|
      vb.name = "AISI-P5-Client"
      vb.cpus = 2
      vb.memory = 2048
      vb.gui = true
      vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
      vb.customize ["modifyvm", :id, "--vram", "32"]
    end
  end
end
