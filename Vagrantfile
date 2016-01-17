Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "192.168.50.4"
  config.ssh.forward_agent = true
  config.vm.synced_folder "email", "/home/vagrant/html-newsletter/email", :owner => "vagrant", :mount_options => [ "dmode=775", "fmode=774" ]
  config.vm.provision "shell", path: "scripts/pre-provision.sh"
  config.vm.provision "shell", path: "scripts/provision.sh", privileged: false
  config.vm.provision "shell", path: "scripts/post-provision.sh", privileged: false
end
