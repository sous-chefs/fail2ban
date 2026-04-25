# fail2ban Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/fail2ban.svg)](https://supermarket.chef.io/cookbooks/fail2ban)
[![CI State](https://github.com/sous-chefs/fail2ban/workflows/ci/badge.svg)](https://github.com/sous-chefs/fail2ban/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Installs and configures `fail2ban`, a utility that watches logs for failed login attempts and blocks repeat offenders with firewall rules. On RHEL-family systems this cookbook can enable the EPEL repository in order to retrieve the fail2ban package.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

- AlmaLinux 8+
- Amazon Linux 2023+
- CentOS Stream 9+
- Debian 12+
- Fedora
- Oracle Linux 8+
- Red Hat Enterprise Linux 8+
- Rocky Linux 8+
- Ubuntu 22.04+

### Chef

- Chef 15.3+

### Cookbooks

- yum-epel

## Migration

This cookbook no longer ships top-level recipes or attributes. See [migration.md](migration.md) for old `fail2ban::default` recipe and `node['fail2ban']` attribute mappings.

## Resources

### fail2ban_install

Installs or removes the fail2ban package. See [documentation/fail2ban_install.md](documentation/fail2ban_install.md).

```ruby
fail2ban_install 'default'
```

### fail2ban_config

Manages `/etc/fail2ban/fail2ban.conf`, `/etc/fail2ban/jail.local`, optional Slack notification files, and compatibility hashes for filters and services. See [documentation/fail2ban_config.md](documentation/fail2ban_config.md).

```ruby
fail2ban_config 'default' do
  ignoreip %w(127.0.0.1/8 10.0.0.0/8)
  maxretry 3
end
```

### fail2ban_service

Manages the fail2ban service. See [documentation/fail2ban_service.md](documentation/fail2ban_service.md).

```ruby
fail2ban_service 'default' do
  action [:enable, :start]
end
```

### fail2ban_filter

Manages fail2ban filters in `/etc/fail2ban/filter.d/`. See [documentation/fail2ban_filter.md](documentation/fail2ban_filter.md).

#### Actions

- `create` - Default. Creates a fail2ban filter.
- `delete` - Deletes a fail2ban filter.

#### Properties

- `filter` - Specifies the name of the filter. This is the name property.
- `source` - Specifies the template source. By default, this is set to `filter.erb`.
- `cookbook` - Specifies the template cookbook. By default, this is set to `fail2ban`.
- `failregex` - Specifies one or multiple regular expressions matching the failure.
- `ignoreregex` - Specifies one or multiple regular expressions to ignore.

#### Examples

Configure a file for webmin authentication with multiple regular expressions matching the failure.

```ruby
fail2ban_filter 'webmin-auth' do
  failregex ["^%(__prefix_line)sNon-existent login as .+ from <HOST>\s*$",
             "^%(__prefix_line)sInvalid login as .+ from <HOST>\s*$"]
end
```

### fail2ban_jail

Manages fail2ban jails in `/etc/fail2ban/jail.d/`. See [documentation/fail2ban_jail.md](documentation/fail2ban_jail.md).

#### Actions

- `create` - Default. Creates a fail2ban jail.
- `delete` - Deletes a fail2ban jail.

#### Properties

- `jail` - Specifies the jail name. This is the name property.
- `source` - Specifies the template source. By default, this is set to `jail.erb`.
- `cookbook` - Specifies the template cookbook. By default, this is set to `fail2ban`.
- `filter` - Specifies the name of the filter to be used by the jail to detect matches.
- `logpath` - Specifies the path to the log file which is provided to the filter.
- `protocol` - Specifies the protocol type, e.g. tcp, udp or all.
- `ports` - Specifies an array of port(s) to watch.
- `maxretry` - Specifies the number of matches which triggers ban action.
- `ignoreips` - Specifies an array of IP addresses to ignore.

#### Examples

Create a new fail2ban jail for SSH that uses existing filter `sshd` and which bans client after 3 tries.

```ruby
fail2ban_jail 'ssh' do
  ports %w(ssh)
  filter 'sshd'
  logpath '/var/log/auth.log'
  maxretry 3
end
```

## Issues related to rsyslog

If you are using rsyslog parameter "$RepeatedMsgReduction on" in rsyslog.conf file
then you can get "Last message repeated N times" in system log file (for example auth.log).
Fail2ban will not work because the internal counter maxretry will not expand the repeated messages.
Change parameter "$RepeatedMsgReduction off" in rsyslog.conf file for maximum accuracy of failed login attempts.

This rsyslog parameter is default ON for ubuntu 12.04 LTS for example.

## Contributors

This project exists thanks to all the people who contribute.

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
