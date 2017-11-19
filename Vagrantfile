hosts = YAML.load_file('./hosts.yaml')

Vagrant.configure("2") do |config|

  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box
  end

  config.vm.box = "ubuntu/xenial64"
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false

  hosts.each do |host|
    config.vm.define host['name'], primary: host.fetch('primary', false) do |node|
      node.vm.hostname = host['name']
      node.vm.network :private_network, ip: host['ip']
      node.hostmanager.aliases = host['aliases']

      if host.has_key?('forwarded_ports')
        host['forwarded_ports'].each do |port|
          node.vm.network "forwarded_port", guest: port['guest'], host: port['host']
        end
      end

      node.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", host['memory']]
        vb.customize ["modifyvm", :id, "--name", host['name']]
      end

      config.vm.provision :hostmanager

      provisioning_script = "scripts/provisioning/#{host['name']}"
      if File.exists?(provisioning_script)
        node.vm.provision "shell"  do |sh|
          sh.path = provisioning_script
        end
      end
    end
  end

end
