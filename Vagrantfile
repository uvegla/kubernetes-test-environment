masters = [
  "172.168.96.100"
]

minions = [
  "172.168.96.111",
  "172.168.96.112",
  "172.168.96.113"
]

Vagrant.configure("2") do |config|

  masters.each do |ip|
    config.vm.define "master" do |master|
      master.vm.box = "bento/centos-7.3"
      master.vm.network "private_network", ip: ip

      config.vm.provision "shell", path: "provision/common.sh"
      config.vm.provision "shell", path: "provision/master.sh"
    end
  end

  minions.each do |ip|
    config.vm.define "minion-#{ip[-1]}" do |minion|
      minion.vm.box = "bento/centos-7.3"
      minion.vm.network "private_network", ip: ip

      config.vm.provision "shell", path: "provision/common.sh"
      config.vm.provision "shell", path: "provision/minion.sh", args: [ip]
    end
  end

end