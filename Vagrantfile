Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "private_network", ip: "10.10.10.10"
  config.vm.hostname = "microk8s"

  config.vm.provider "virtualbox" do |vb|
    vb.name ="microk8s"
    vb.gui = false
    vb.linked_clone = true
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
    vb.memory = 1024 * 5
    vb.cpus = 3
  end

  config.vm.provision "shell", run: "up", inline: <<-SHELL
    apt-get update
  SHELL

  config.vm.provision "microk8s", type: "shell", run: "never", path: "./scripts/microk8s.sh"

end
