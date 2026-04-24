# Migration Guide

This release completes the migration from a recipe and attribute cookbook to a
custom-resource cookbook.

## What Changed

The top-level `attributes/` and `recipes/` directories were removed. The old
`fail2ban::default` recipe installed packages, rendered `/etc/fail2ban/fail2ban.conf`,
rendered `/etc/fail2ban/jail.local`, optionally rendered Slack notification files,
and managed the `fail2ban` service from node attributes.

Use the new resources directly in your own recipes:

```ruby
fail2ban_install 'default'

fail2ban_config 'default' do
  ignoreip %w(127.0.0.1/8 10.0.0.0/8)
  bantime 600
  maxretry 5
end

fail2ban_service 'default' do
  action [:enable, :start]
end
```

## Attribute Migration

The old attributes now map to properties on `fail2ban_config`.

* `node['fail2ban']['loglevel']`: `loglevel`
* `node['fail2ban']['logtarget']`: `logtarget`
* `node['fail2ban']['syslogsocket']`: `syslogsocket`
* `node['fail2ban']['socket']`: `socket`
* `node['fail2ban']['pidfile']`: `pidfile`
* `node['fail2ban']['dbfile']`: `dbfile`
* `node['fail2ban']['dbpurgeage']`: `dbpurgeage`
* `node['fail2ban']['ignoreip']`: `ignoreip`
* `node['fail2ban']['findtime']`: `findtime`
* `node['fail2ban']['bantime']`: `bantime`
* `node['fail2ban']['maxretry']`: `maxretry`
* `node['fail2ban']['backend']`: `backend`
* `node['fail2ban']['email']`: `email`
* `node['fail2ban']['sendername']`: `sendername`
* `node['fail2ban']['action']`: `action_name`
* `node['fail2ban']['banaction']`: `banaction`
* `node['fail2ban']['mta']`: `mta`
* `node['fail2ban']['protocol']`: `protocol`
* `node['fail2ban']['chain']`: `chain`
* `node['fail2ban']['filters']`: `filters` or `fail2ban_filter`
* `node['fail2ban']['services']`: `services` or `fail2ban_jail`
* `node['fail2ban']['slack_webhook']`: `slack_webhook`
* `node['fail2ban']['slack_channel']`: `slack_channel`

## Recipe Migration

Replace `include_recipe 'fail2ban'` with explicit resources:

```ruby
fail2ban_install 'default' do
  install_curl true
end

fail2ban_config 'default' do
  slack_webhook 'https://hooks.slack.com/services/example'
  slack_channel 'infra'
end

fail2ban_service 'default' do
  action [:enable, :start]
end
```

Use `fail2ban_filter` and `fail2ban_jail` for individual files:

```ruby
fail2ban_filter 'webmin-auth' do
  failregex ['^%(__prefix_line)sInvalid login as .+ from <HOST>\s*$']
end

fail2ban_jail 'ssh' do
  ports %w(ssh)
  filter 'sshd'
  logpath '/var/log/auth.log'
  maxretry 3
end
```

## Platform Notes

RHEL-family systems use EPEL for fail2ban except Amazon Linux 2023, which ships
fail2ban in Amazon Linux repositories. SUSE/openSUSE support was removed because
Leap 15.6 is at EOL and Leap 16.0 does not currently list an official fail2ban
package.
