# fail2ban_config

Manages fail2ban main configuration, jail defaults, optional legacy filter hash
entries, and optional Slack notification files.

## Actions

* `:create`: Creates fail2ban configuration. Default.
* `:delete`: Removes the managed main config and jail config files.

## Properties

* `config_file`: String. Default: `'/etc/fail2ban/fail2ban.conf'`. Main fail2ban config path.
* `cookbook`: String. Default: `'fail2ban'`. Template cookbook.
* `jail_file`: String. Default: `'/etc/fail2ban/jail.local'`. Jail defaults config path.
* `loglevel`: String. Default: `'INFO'`. Fail2ban log level.
* `logtarget`: String. Default: `'/var/log/fail2ban.log'`. Fail2ban log target.
* `syslogsocket`: String. Default: `'auto'`. Syslog socket setting.
* `socket`: String. Default: `'/var/run/fail2ban/fail2ban.sock'`. Fail2ban socket path.
* `pidfile`: String. Default: `'/var/run/fail2ban/fail2ban.pid'`. Fail2ban PID file path.
* `dbfile`: String. Default: `'/var/lib/fail2ban/fail2ban.sqlite3'`. Fail2ban database path.
* `dbpurgeage`: Integer or String. Default: `86400`. Database purge age.
* `ignoreip`: String or Array. Default: `'127.0.0.1/8'`. IPs or CIDRs to ignore.
* `findtime`: Integer or String. Default: `600`. Find time setting.
* `bantime`: Integer or String. Default: `300`. Ban time setting.
* `maxretry`: Integer or String. Default: `5`. Default retry limit.
* `backend`: String. Default: `'polling'`. Fail2ban backend setting.
* `email`: String. Default: `'root@localhost'`. Destination email.
* `sendername`: String. Default: `'Fail2Ban'`. Sender name.
* `action_name`: String. Default: `'action_'`. Default fail2ban action shortcut.
* `banaction`: String. Default: `'iptables-multiport'`. Default ban action.
* `mta`: String. Default: `'sendmail'`. MTA action setting.
* `protocol`: String. Default: `'tcp'`. Default protocol.
* `chain`: String. Default: `'INPUT'`. Firewall chain.
* `filters`: Hash. Default: `{}`. Legacy filter hash rendered to `filter.d`.
* `services`: Hash. Default: SSH jail defaults. Legacy service hash rendered to `jail.local`.
* `slack_webhook`: String. Default: `nil`. Slack webhook URL.
* `slack_channel`: String. Default: `'general'`. Slack channel without `#`.
* `remove_default_jail_files`: true or false. Default: `true`. Removes distro default jail snippets that conflict with managed config.
* `service_resource`: String. Default: `'fail2ban_service[default]'`. Resource notified on config changes.

## Examples

```ruby
fail2ban_config 'default' do
  ignoreip %w(127.0.0.1/8 10.0.0.0/8)
  maxretry 3
end
```

```ruby
fail2ban_config 'default' do
  slack_webhook 'https://hooks.slack.com/services/example'
  slack_channel 'infra'
end
```
