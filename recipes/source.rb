
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
  command "pwd && cp /var/chef/cache/fail2ban-#{node['fail2ban']['source']['version']}/files/redhat-initd /etc/init.d/fail2ban && chmod 755 /etc/init.d/fail2ban && chkconfig --add fail2ban && chkconfig fail2ban on"
end
