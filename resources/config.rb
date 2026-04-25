# frozen_string_literal: true

provides :fail2ban_config
unified_mode true

property :config_file, String, default: '/etc/fail2ban/fail2ban.conf'
property :cookbook, String, default: 'fail2ban'
property :jail_file, String, default: '/etc/fail2ban/jail.local'
property :loglevel, String, default: 'INFO'
property :logtarget, String, default: '/var/log/fail2ban.log'
property :syslogsocket, String, default: 'auto'
property :socket, String, default: '/var/run/fail2ban/fail2ban.sock'
property :pidfile, String, default: '/var/run/fail2ban/fail2ban.pid'
property :dbfile, String, default: '/var/lib/fail2ban/fail2ban.sqlite3'
property :dbpurgeage, [Integer, String], default: 86_400
property :ignoreip, [String, Array], default: '127.0.0.1/8'
property :findtime, [Integer, String], default: 600
property :bantime, [Integer, String], default: 300
property :maxretry, [Integer, String], default: 5
property :backend, String, default: 'polling'
property :email, String, default: 'root@localhost'
property :sendername, String, default: 'Fail2Ban'
property :action_name, String, default: 'action_'
property :banaction, String, default: 'iptables-multiport'
property :mta, String, default: 'sendmail'
property :protocol, String, default: 'tcp'
property :chain, String, default: 'INPUT'
property :filters, Hash, default: {}
property :services, Hash, default: {}
property :slack_webhook, String
property :slack_channel, String, default: 'general'
property :remove_default_jail_files, [true, false], default: true
property :service_resource, String, default: 'fail2ban_service[default]'

action_class do
  def auth_log
    if platform_family?('rhel', 'fedora', 'amazon')
      '/var/log/secure'
    else
      '/var/log/auth.log'
    end
  end

  def default_services
    services = {
      'ssh' => {
        'enabled' => 'true',
        'port' => 'ssh',
        'filter' => 'sshd',
        'logpath' => auth_log,
        'maxretry' => '6',
      },
    }

    services['ssh-iptables'] = { 'enabled' => false } if platform_family?('rhel', 'fedora', 'amazon')
    services
  end

  def deep_stringify_hash(hash)
    hash.to_h.each_with_object({}) do |(key, value), result|
      result[key.to_s] = value.respond_to?(:to_hash) ? deep_stringify_hash(value) : value
    end
  end
end

action :create do
  deep_stringify_hash(new_resource.filters).each do |filter_name, options|
    template "/etc/fail2ban/filter.d/#{filter_name}.conf" do
      cookbook new_resource.cookbook
      source 'filter.conf.erb'
      variables(
        failregex: [options['failregex']].flatten.compact,
        ignoreregex: [options['ignoreregex']].flatten.compact
      )
      notifies :restart, new_resource.service_resource
    end
  end

  template new_resource.config_file do
    cookbook new_resource.cookbook
    source 'fail2ban.conf.erb'
    variables(
      loglevel: new_resource.loglevel,
      logtarget: new_resource.logtarget,
      syslogsocket: new_resource.syslogsocket,
      socket: new_resource.socket,
      pidfile: new_resource.pidfile,
      dbfile: new_resource.dbfile,
      dbpurgeage: new_resource.dbpurgeage
    )
    notifies :restart, new_resource.service_resource
  end

  template new_resource.jail_file do
    cookbook new_resource.cookbook
    source 'jail.conf.erb'
    variables(
      ignoreip: new_resource.ignoreip,
      findtime: new_resource.findtime,
      bantime: new_resource.bantime,
      maxretry: new_resource.maxretry,
      backend: new_resource.backend,
      email: new_resource.email,
      sendername: new_resource.sendername,
      action_name: new_resource.action_name,
      banaction: new_resource.banaction,
      mta: new_resource.mta,
      protocol: new_resource.protocol,
      chain: new_resource.chain,
      services: deep_stringify_hash(new_resource.services.empty? ? default_services : new_resource.services),
      slack_webhook: new_resource.slack_webhook
    )
    notifies :restart, new_resource.service_resource
  end

  template '/etc/fail2ban/action.d/slack.conf' do
    cookbook new_resource.cookbook
    source 'slack.conf.erb'
    notifies :restart, new_resource.service_resource
    only_if { new_resource.slack_webhook }
  end

  template '/etc/fail2ban/slack_notify.sh' do
    cookbook new_resource.cookbook
    source 'slack_notify.sh.erb'
    owner 'root'
    group 'root'
    mode '0750'
    variables(
      slack_channel: new_resource.slack_channel,
      slack_webhook: new_resource.slack_webhook
    )
    notifies :restart, new_resource.service_resource
    only_if { new_resource.slack_webhook }
  end

  file '/etc/fail2ban/jail.d/defaults-debian.conf' do
    action :delete
    only_if { new_resource.remove_default_jail_files && platform?('ubuntu') }
  end

  file '/etc/fail2ban/jail.d/00-firewalld.conf' do
    action :delete
    only_if { new_resource.remove_default_jail_files && platform?('centos', 'centos_stream') }
  end
end

action :delete do
  file new_resource.config_file do
    action :delete
    notifies :restart, new_resource.service_resource
  end

  file new_resource.jail_file do
    action :delete
    notifies :restart, new_resource.service_resource
  end
end
