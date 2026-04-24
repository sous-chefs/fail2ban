# frozen_string_literal: true

provides :fail2ban_install
unified_mode true

property :package_name, [String, Array], default: 'fail2ban'
property :install_curl, [true, false], default: false
property :manage_epel, [true, false], default: lazy { platform_family?('rhel') }
property :manage_epel_next, [true, false], default: lazy { !(platform?('centos') && node['platform_version'].to_i >= 10) }

action :install do
  node.default['yum']['epel-next']['managed'] = false unless new_resource.manage_epel_next

  include_recipe 'yum-epel' if new_resource.manage_epel

  ohai 'reload package list' do
    plugin 'packages'
    action :nothing
  end

  package new_resource.package_name do
    action :install
    notifies :reload, 'ohai[reload package list]', :immediately
  end

  package 'curl' do
    action :install
    notifies :reload, 'ohai[reload package list]', :immediately
    only_if { new_resource.install_curl }
  end
end

action :remove do
  package new_resource.package_name do
    action :remove
  end
end
