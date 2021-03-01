require_relative "variables.rb"

Vagrant.configure("2") do |config|
  config.vm.box = VmOS
  config.vm.provider Provider do |v|
    v.cpus = CpuCount
    v.memory = Ram
  end
  config.vm.provision "shell", inline: "cat /vagrant/keys/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys"

  config.vm.define "edgeNode" do |node|
    node.vm.hostname = "edgeNode"
    node.vm.provision "shell", inline: "cp /vagrant/keys/id_rsa /home/vagrant/.ssh/master_key"
    node.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "/vagrant/playbook.yml"
    end
  end
      
  (1..ENV['nameNodeCount'].to_i).each do |i|
    config.vm.define "nameNode-#{i}" do |node|
      node.vm.hostname = "nameNode-#{i}"
    end
  end

  (1..ENV['dataNodeCount'].to_i).each do |i|
    config.vm.define "dataNode-#{i}" do |node|
      node.vm.hostname = "dataNode-#{i}"
    end
  end

end
