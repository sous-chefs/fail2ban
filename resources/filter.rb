# frozen_string_literal: true

provides :fail2ban_filter
unified_mode true

property :filter, String, name_property: true
property :source, String, default: 'filter.erb'
property :cookbook, String, default: 'fail2ban'
property :failregex, [String, Array]
property :ignoreregex, [String, Array]
property :service_resource, String, default: 'fail2ban_service[default]'

action :create do
  template "/etc/fail2ban/filter.d/#{new_resource.filter}.conf" do
    cookbook new_resource.cookbook
    source new_resource.source
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      failregex: new_resource.failregex,
      ignoreregex: new_resource.ignoreregex
    )
    notifies :reload, new_resource.service_resource
  end
end

action :delete do
  file "/etc/fail2ban/filter.d/#{new_resource.filter}.conf" do
    action :delete
    notifies :reload, new_resource.service_resource
  end
end
