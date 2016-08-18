#
# Cookbook Name:: chef-provisioning-vagrant-helper
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'chef-provisioning-vagrant-helper::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end
  end
end

describe 'test::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'converges the machine with the correct machine_options' do
      expect(chef_run).to converge_machine('mario')
        .with(machine_options: {
          :vagrant_options => {
            "vm.box" => "bento/ubuntu-14.04",
            "vm.box_url" => nil,
            "vm.hostname" => "mario.example.com"
          },
          :vagrant_config=> <<-ENDCONFIG
    config.vm.provider 'virtualbox' do |v|
      v.customize [
        'modifyvm', :id,
        '--name', "mario.example.com",
        '--memory', "512",
        '--cpus', "1",
        '--natdnshostresolver1', 'on',
        '--usb', 'off',
        '--usbehci', 'off'
      ]
    end
    if Vagrant.has_plugin?("vagrant-cachier")
      config.cache.scope = :box
      config.cache.enable :generic, { :cache_dir => "/var/chef/cache" }
    end
          ENDCONFIG
        }
        )
    end
  end
end

describe 'test::advanced' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

it 'converges the machine with the correct machine_options' do
      expect(chef_run).to converge_machine('mario')
        .with(machine_options: {
          :vagrant_options => {
            "vm.box" => "bento/ubuntu-16.04",
            "vm.box_url" => nil,
            "vm.hostname" => "mario.example.com"
          },
          :vagrant_config=> <<-ENDCONFIG
    config.vm.provider 'virtualbox' do |v|
      v.customize [
        'modifyvm', :id,
        '--name', "mario.example.com",
        '--memory', "1024",
        '--cpus', "2",
        '--natdnshostresolver1', 'on',
        '--usb', 'off',
        '--usbehci', 'off'
      ]
    end
    config.vm.network 'private_network', type: 'dhcp'
    config.vm.network 'private_network', ip: "33.33.33.10"
    if Vagrant.has_plugin?("vagrant-cachier")
      config.cache.scope = :box
      config.cache.enable :generic, { :cache_dir => "/var/chef/cache" }
    end
          ENDCONFIG
        }
        )
    end
  end
end
