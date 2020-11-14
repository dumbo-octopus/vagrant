$keyscript = <<-SCRIPT
cat /vagrant/keys/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
SCRIPT


$edgescript = <<-SCRIPT
sudo yum install epel-release -y
sudo yum install ansible -y
sudo cp -r /vagrant/keys/id_rsa /home/vagrant/.ssh/id_rsa
sudo chmod 400  /home/vagrant/.ssh/id_rsa
sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
SCRIPT


Vagrant.configure("2") do |config|

  config.vm.define "edgeNode" do |node|
    node.vm.box = ENV['vmOS']
    node.vm.hostname = "edgeNode"
    node.vm.provider ENV['provider'] do |v| #libvirt -> virtualbox
        v.cpus=ENV['cpuCount']
        v.memory=ENV['ram']
    end
    node.vm.provision "shell", inline: $edgescript
  end
      
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
