#
# Cookbook Name:: chef-provisioning-vagrant-helper
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# This recipe sets up a local chef-zero server for provisioning - note the paths from the attributes file

require 'chef/provisioning/vagrant_driver'

vagrants_dir = node['chef-provisioning-vagrant']['vagrants_dir']

log "[chef-provisioning-vagrant] Your vagrantfiles will be located in: #{vagrants_dir}"

directory vagrants_dir
vagrant_cluster vagrants_dir

with_chef_local_server :chef_repo_path => node['chef-provisioning-vagrant']['chef_repo'],
  :cookbook_path => [ node['chef-provisioning-vagrant']['vendor_cookbooks_path'] ],
  :port => 9010.upto(9999)
