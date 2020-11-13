$keyscript = <<-SCRIPT
cat /vagrant/keys/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
SCRIPT

Vagrant.configure("2") do |config|
      
  (1..ENV['nameNodeCount'].to_i).each do |i|
    config.vm.define "nameNode-#{i}" do |node|
      node.vm.box = ENV['vmOS']
      node.vm.hostname = "nameNode-#{i}"
      node.vm.provider ENV['provider'] do |v| #libvirt -> virtualbox
        v.cpus=ENV['cpuCount']
        v.memory=ENV['ram']
      end
      node.vm.provision "shell", inline: $keyscript
    end
  end

  (1..ENV['dataNodeCount'].to_i).each do |i|
    config.vm.define "dataNode-#{i}" do |node|
      node.vm.box = ENV['vmOS']
      node.vm.hostname = "dataNode-#{i}"
      node.vm.provider ENV['provider'] do |v| #libvirt -> virtualbox
        v.cpus=ENV['cpuCount']
        v.memory=ENV['ram']
      end
      node.vm.provision "shell", inline: $keyscript
    end
  end

end
