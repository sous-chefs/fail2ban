apt_update if platform_family?('debian')

auth_log = if platform_family?('rhel', 'fedora', 'amazon')
             '/var/log/secure'
           else
             '/var/log/auth.log'
           end

file auth_log do
  owner 'root'
  group 'root'
  mode '0600'
  action :create_if_missing
end

fail2ban_service 'default' do
  action :nothing
end

fail2ban_install 'default'

fail2ban_config 'default' do
  ignoreip %w(1.2.3.4 5.6.7.8)
  action :create
end

fail2ban_service 'default' do
  action [:enable, :start]
end
