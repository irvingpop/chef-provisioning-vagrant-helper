# encoding: utf-8

# # example:
# vagrant_options('myhost.chef.io', config: {
#     box: 'opscode-ubuntu-14.04',
#     box_url: ''
#     ram: 512,
#     cpus: 2,
#     private_networks: {
#       default: 'dhcp',
#       cluster_ip: '33.33.33.10'
#     }
#   }
# )

module VagrantConfigHelper

  def vagrant_options(vmname = 'default.example.com', params = {})
    config = params[:config] || {}
    {
      :vagrant_options => {
        'vm.box' => config[:box] || node['chef-provisioning-vagrant']['vbox']['box'],
        'vm.box_url' => config[:box_url] || node['chef-provisioning-vagrant']['vbox']['box_url'],
        'vm.hostname' => vmname
      },
      :vagrant_config => generate_vagrant_config(vmname, config)
    }
  end

  def generate_vagrant_config(vmname, config)
    # Vagrant/Virtualbox notes:
    # * it sucks that you have to hardcode "IDE Controller", recent opscode
    #   packer images switched to IDE, but we can't easily detect SATA
    # * virtio network interfaces, in some circumstances, provide MUCH WORSE
    #   performance than good ol' e1000 (the default)
    # * What's the point of the "nonrotational" flag?  tells you the underlying
    #   disk is an SSD.  This should be fine for most of our recent Macs, but I'm
    #   not sure if there's any actual benefit for ext4

    vagrant_config = <<-ENDCONFIG
    config.vm.provider 'virtualbox' do |v|
      v.customize [
        'modifyvm', :id,
        '--name', "#{vmname}",
        '--memory', "#{config[:ram] || node['chef-provisioning-vagrant']['vbox']['ram']}",
        '--cpus', "#{config[:cpus] || node['chef-provisioning-vagrant']['vbox']['cpus']}",
        '--natdnshostresolver1', 'on',
        '--usb', 'off',
        '--usbehci', 'off'
      ]
    end
    ENDCONFIG

    private_networks = config[:private_networks] || node['chef-provisioning-vagrant']['vbox']['private_networks']
    private_networks.each do |network, network_type|
      if network_type == 'dhcp'
        vagrant_config += <<-ENDCONFIG
    config.vm.network 'private_network', type: 'dhcp'
        ENDCONFIG
      else
        vagrant_config += <<-ENDCONFIG
    config.vm.network 'private_network', ip: "#{network_type}"
        ENDCONFIG
      end
    end

    vagrant_config
  end
end

Chef::Recipe.send(:include, VagrantConfigHelper)
Chef::Resource.send(:include, VagrantConfigHelper)
