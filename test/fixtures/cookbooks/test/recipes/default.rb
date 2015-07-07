
include_recipe 'chef-provisioning-vagrant-helper::default'

machine 'mario' do
  recipe 'mario::default'
  machine_options vagrant_options('mario.example.com')
end
