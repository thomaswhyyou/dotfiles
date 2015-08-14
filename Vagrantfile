# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  dirpath = Dir.getwd                                                # Find out where I am in host machine;
  dirname = File.basename(dirpath).downcase                          # And the name of directory;

  vagrant_hostname_main = "#{dirname.gsub("_", "-")}-main"
  config.vm.define "#{vagrant_hostname_main}" do |main|
    main.vm.hostname = "#{vagrant_hostname_main}"
  end

  # Connect host-guest networking
  config.vm.network "private_network", ip: "192.168.56.10"
  config.vm.network "forwarded_port", guest: 5000, host: 5000

  # Use host ssh credentials in guest vm; ssh agent must be running on host
  config.ssh.forward_agent = true

  # make host graphical session available to the remote machine (only relevant if x11/gui available in guest)
  config.ssh.forward_x11 = true

  # Configure shared folder
  vagrant_mount_path = "/home/vagrant/#{dirname}"                    # Where in guest shared folder should mount;
  config.vm.synced_folder dirpath, "/vagrant", disabled: true        # disable default vagrant mounting;
  config.vm.synced_folder dirpath, vagrant_mount_path                # and instead mount it per vagrant_mount_path

  # Provision initial setps of guest vm
  config.vm.provision "file", source: "~/.bash_profile", destination: "~/.bash_profile"

  maybe_playbook = "#{dirpath}/ansible/vagrant.yml"
  if File.exist?(maybe_playbook)
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = maybe_playbook
      ansible.verbose = "vvv"
      ansible.extra_vars = {
        vagrant_mount_path: vagrant_mount_path,                     # Used in playbooks
        vagrant_hostname_main: vagrant_hostname_main                # Give it to "hosts" in ansible yml
      }
      ansible.ask_vault_pass = true
    end
  end

  # Customize some vb configurations
  config.vm.provider "virtualbox" do |vb|
    # vb.customize ["modifyvm", :id, "--memory", "2048"]
    # vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
  end

end
