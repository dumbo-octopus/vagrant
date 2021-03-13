require_relative "variables.rb"

inventory_common = %{[all:children]
  edgeNode
  nameNode
  dataNode

[all:vars]
  ansible_ssh_user=vagrant
  ansible_ssh_private_key_file=/vagrant/keys/id_rsa
}

File.open("ansible/inventory", 'w') { |file| file.truncate(0)
  file.write(inventory_common)
}

Vagrant.configure("2") do |config|
  config.vm.box = VmOS
  config.vm.provider Provider do |v|
    v.cpus = CpuCount
    v.memory = Ram
  end
  #config.vm.synced_folder ".", "/vagrant", disabled: false
  config.vm.provision "shell", inline: "cat /vagrant/keys/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys && chmod 600 /home/vagrant/.ssh/authorized_keys"


  config.vm.define "edgeNode" do |node|
    node.vm.hostname = "edgeNode.vm.test"
    node.vm.network :private_network, ip:"192.168.60.9"
    node.vm.provision "shell", inline: "cp /vagrant/keys/id_rsa /home/vagrant/.ssh/master_key && chmod 600 /home/vagrant/.ssh/master_key"
    # prototype dynamic inventory
    node.vm.provision "shell", inline: "echo '[edgeNode]\n192.168.60.9' >> /vagrant/ansible/inventory"
    node.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "/vagrant/ansible/playbook.yml"
    end
  end
      
  (1..NameNodeCount.to_i).each do |i|
    config.vm.define "nameNode-#{i}" do |node|
      # prototype dynamic inventory
      node.vm.provision "shell", inline: "echo '[nameNode]\n192.168.60.#{i+10}' >> /vagrant/ansible/inventory"
      node.vm.hostname = "nameNode-#{i}.vm.test"
      node.vm.network :private_network, ip:"192.168.60.#{i+10}"
    end
  end

  (1..DataNodeCount.to_i).each do |i|
    config.vm.define "dataNode-#{i}" do |node|
      # prototype dynamic inventory
      node.vm.provision "shell", inline: "echo '[dataNode]\n192.168.70.#{i+10}' >> /vagrant/ansible/inventory"
      node.vm.hostname = "dataNode-#{i}.vm.test"
      node.vm.network :private_network, ip:"192.168.70.#{i+10}"
    end
  end

end
