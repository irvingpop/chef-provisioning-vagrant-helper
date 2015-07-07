include_recipe 'chef-provisioning-vagrant-helper::default'

machine "mario" do
  recipe 'mario::default'
  machine_options vagrant_options("mario.example.com", config: {
      box: 'opscode-ubuntu-15.04',
      ram: 1024,
      cpus: 2,
      private_networks: {
        default: 'dhcp',
        cluster_ip: '33.33.33.10'
      }
    })
end
