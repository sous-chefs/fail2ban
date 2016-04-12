
fail2ban_deps = %w(python)
            
fail2ban_deps.each do |pkg|
  package pkg do
    action :install
  end
end

bash 'install-fail2ban' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
   tar -xzf fail2ban-#{node['fail2ban']['source']['version']}.tar.gz
    (cd fail2ban-#{node['fail2ban']['source']['version']} &&  python setup.py install)
  EOH
  user 'root'
  action :nothing 
end

remote_file File.join(Chef::Config[:file_cache_path], "fail2ban-#{node['fail2ban']['source']['version']}.tar.gz") do
  source node['fail2ban']['source']['url']
  owner 'root'
  mode 0644
  notifies :run, 'bash[install-fail2ban]', :immediately
end

execute 'copy-config' do
  command 'pwd && cp /var/chef/cache/fail2ban-0.9.3/files/redhat-initd /etc/init.d/fail2ban && chmod 755 /etc/init.d/fail2ban && chkconfig --add fail2ban && chkconfig fail2ban on'
end

node['fail2ban']['filters'].each do |name, options|
  template "/etc/fail2ban/filter.d/#{name}.conf" do
    source 'filter.conf.erb'
    variables(failregex: [options['failregex']].flatten, ignoreregex: [options['ignoreregex']].flatten)
    notifies :restart, 'service[fail2ban]'
  end
end

template '/etc/fail2ban/fail2ban.conf' do
  source 'fail2ban.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[fail2ban]'
end

template '/etc/fail2ban/jail.local' do
  source 'jail.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[fail2ban]'
end

service 'fail2ban' do
  supports [status: true, restart: true]
  action [:enable, :start]

  if (platform?('ubuntu') && node['platform_version'].to_f < 12.04) ||
     (platform?('debian') && node['platform_version'].to_f < 7)
    # status command returns non-0 value only since fail2ban 0.8.6-3 (Debian)
    status_command "/etc/init.d/fail2ban status | grep -q 'is running'"
  end
end
