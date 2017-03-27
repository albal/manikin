Vagrant::Config.run do |config|
  config.vm.box       = "bento/centos-7.3"
  config.vm.host_name = "dev.puppetlabs.vm"
  config.vm.forward_port 8080, 8080
  config.vm.forward_port 80, 8888
  config.vm.provision :shell, :path => "puppet-bootstrap-centos7.sh"

  # Puppet Shared Folder
  config.vm.share_folder "puppet_mount", "/puppet", "puppet"
 
  # Puppet Provisioner setup
  config.vm.provision :puppet do |puppet|
  puppet.manifests_path = "puppet/manifests"
  puppet.module_path    = ["puppet/modules", "puppet/custom"]
  puppet.manifest_file  = "site.pp"
  end
end
