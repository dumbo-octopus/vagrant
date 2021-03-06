require_relative "variables.rb"

Vagrant.configure("2") do |config|
  config.vm.box = VmOS
  config.vm.provider Provider do |v|
    v.cpus = CpuCount
    v.memory = Ram
  end
  config.vm.provision "shell", inline: "cat /vagrant/keys/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys && chmod 600 /home/vagrant/.ssh/authorized_keys"

  config.vm.define "edgeNode" do |node|
    node.vm.hostname = "edgeNode"
    node.vm.network :private_network, ip:"192.168.60.9"
    node.vm.provision "shell", inline: "cp /vagrant/keys/id_rsa /home/vagrant/.ssh/master_key && chmod 600 /home/vagrant/.ssh/authorized_keys"
    node.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "/vagrant/playbook.yml"
    end
  end
      
  (1..NameNodeCount.to_i).each do |i|
    config.vm.define "nameNode-#{i}" do |node|
      node.vm.hostname = "nameNode-#{i}"
      node.vm.network :private_network, ip:"192.168.60.#{i+10}"
    end
  end

  (1..DataNodeCount.to_i).each do |i|
    config.vm.define "dataNode-#{i}" do |node|
      node.vm.hostname = "dataNode-#{i}"
      node.vm.network :private_network, ip:"192.168.70.#{i+10}"
    end
  end

end