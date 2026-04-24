# frozen_string_literal: true

provides :fail2ban_jail
unified_mode true

property :bantime, [Integer, String]
property :cookbook, String, default: 'fail2ban'
property :filter, String
property :ignoreips, Array
property :jail, String, name_property: true
property :logpath, String
property :maxretry, Integer
property :ports, Array, default: []
property :priority, [String, Integer], default: '50'
property :protocol, String
property :source, String, default: 'jail.erb'
property :service_resource, String, default: 'fail2ban_service[default]'

action :create do
  template "/etc/fail2ban/jail.d/#{new_resource.priority}-#{new_resource.jail}.conf" do
    cookbook new_resource.cookbook
    source new_resource.source
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      bantime: new_resource.bantime,
      filter: new_resource.filter,
      ignoreips: new_resource.ignoreips,
      logpath: new_resource.logpath,
      maxretry: new_resource.maxretry,
      name: new_resource.jail,
      ports: new_resource.ports,
      protocol: new_resource.protocol
    )
    notifies :reload, new_resource.service_resource
  end
end

action :delete do
  file "/etc/fail2ban/jail.d/#{new_resource.priority}-#{new_resource.jail}.conf" do
    action :delete
    notifies :reload, new_resource.service_resource
  end
end
