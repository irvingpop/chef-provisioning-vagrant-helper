# encoding: utf-8

# chef-zero attributes
default['chef-provisioning-vagrant']['chef_repo'] = Chef::Config[:chef_repo_path]
default['chef-provisioning-vagrant']['vagrants_dir'] = ::File.join(Chef::Config[:chef_repo_path], 'vagrants')
default['chef-provisioning-vagrant']['vendor_cookbooks_path'] = ::File.join(Chef::Config[:chef_repo_path], 'vendor')
default['chef-provisioning-vagrant']['use_local_chef_server'] = true
# machine details
default['chef-provisioning-vagrant']['vbox']['box'] = 'opscode-ubuntu-14.04'
default['chef-provisioning-vagrant']['vbox']['box_url'] = 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box'
default['chef-provisioning-vagrant']['vbox']['ram'] = 512
default['chef-provisioning-vagrant']['vbox']['cpus'] = 1

default['chef-provisioning-vagrant']['vbox']['private_networks'] = {}
# provide a list of private network interfaces to provisioning
# default['chef-provisioning-vagrant']['vbox']['private_networks']['default'] = 'dhcp'
# default['chef-provisioning-vagrant']['vbox']['private_networks']['cluster_ip'] = '33.33.33.10'
