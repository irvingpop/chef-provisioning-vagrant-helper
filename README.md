# chef-provisioning-vagrant-helper

This cookbook provides helper recipes and methods for using [chef-provisioning-vagrant](https://github.com/chef/chef-provisioning-vagrant)

# Usage

To establish identical settings for all of the machines in your cluster, set the following attributes in your wrapper cookbook:

```ruby
# chef-zero attributes
default['chef-provisioning-vagrant']['chef_repo'] = Chef::Config[:chef_repo_path]
default['chef-provisioning-vagrant']['vagrants_dir'] = ::File.join(Chef::Config[:chef_repo_path], 'vagrants')
default['chef-provisioning-vagrant']['vendor_cookbooks_path'] = ::File.join(Chef::Config[:chef_repo_path], 'vendor')

# machine details
default['chef-provisioning-vagrant']['vbox']['box'] = 'opscode-ubuntu-14.04'
default['chef-provisioning-vagrant']['vbox']['box_url'] = 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box'
default['chef-provisioning-vagrant']['vbox']['ram'] = 512
default['chef-provisioning-vagrant']['vbox']['cpus'] = 1

# private networking interfaces
default['chef-provisioning-vagrant']['vbox']['private_networks']['default'] = 'dhcp'
```

Then simply use it in your recipe:

```ruby
include_recipe 'chef-provisioning-vagrant-helper::default'

machine "mario" do
  recipe 'mario::default'
  machine_options vagrant_options("mario.example.com")
end
```

# Advanced usage

You can override the settings on a per-machine basis like so:

```ruby
include_recipe 'chef-provisioning-vagrant-helper::default'

machine "mario" do
  recipe 'mario::default'
  machine_options vagrant_options("mario.example.com", config: {
      box: 'opscode-ubuntu-14.04',
      ram: 1024,
      cpus: 2,
      private_networks: {
        default: 'dhcp',
        cluster_ip: '33.33.33.10'
      }
    })
end

```
