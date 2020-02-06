plugins_dependencies = %w( vagrant-hostmanager )
plugin_status = false
plugins_dependencies.each do |plugin_name|
  unless Vagrant.has_plugin? plugin_name
    system("vagrant plugin install #{plugin_name}")
    plugin_status = true
    puts " #{plugin_name}  Dependencies installed"
  end
end

if plugin_status === true
  exec "vagrant #{ARGV.join' '}"
else
  puts "All Plugin Dependencies already installed"
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.define "microk8s" do |c|
    c.vm.hostname = "microk8s"
    c.vm.network "private_network", ip: "192.168.50.10"
    # c.vm.provision "ansible", playbook: "ansible/initial.yml", run: "always"
    c.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.linked_clone = true
      vb.memory = 1024 * 4
      vb.cpus = 2
    end
    c.vm.post_up_message = "Please open http://microk8s:30001 and use links"
  end

  config.vm.provision "shell", run: "up", inline: <<-SHELL
    apt-get update
  SHELL

  config.vm.provision "microk8s", type: "shell", run: "never", path: "./scripts/microk8s.sh"

end
