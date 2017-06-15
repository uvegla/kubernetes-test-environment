masters = [
  "172.168.96.100"
]

minions = [
  "172.168.96.110",
  "172.168.96.111",
  "172.168.96.112"
]

Vagrant.configure("2") do |config|

  masters.each do |ip|
    config.vm.define "kubernetes-master-#{ip}" do |master|
      master.vm.box = "bento/centos-7.3"
      master.vm.network "private_network", ip: ip

      config.vm.provision "shell", path: "provision/common.sh"
      config.vm.provision "shell", path: "provision/master.sh"
    end
  end

  minion_no = 1
  minions.each do |ip|
    config.vm.define "kubernetes-minion-#{ip}" do |minion|
      minion.vm.box = "bento/centos-7.3"
      minion.vm.network "private_network", ip: ip

      config.vm.provision "shell", path: "provision/common.sh"
      config.vm.provision "shell", path: "provision/minion.sh", args: [minion_no]
    end

    minion_no += 1
  end

end