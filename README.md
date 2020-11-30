# fail2ban Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/fail2ban.svg)](https://supermarket.chef.io/cookbooks/fail2ban)
[![CI State](https://github.com/sous-chefs/fail2ban/workflows/ci/badge.svg)](https://github.com/sous-chefs/fail2ban/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Installs and configures `fail2ban`, a utility that watches logs for failed login attempts and blocks repeat offenders with firewall rules. On Redhat systems this cookbook will enable the EPEL repository in order to retrieve the fail2ban package.

## Requirements

### Platforms

- Debian/Ubuntu
- RHEL/CentOS/Scientific/Amazon/Oracle
- Fedora
- OpenSUSE

### Chef

- Chef 13.0+

### Cookbooks

- yum-epel

## Recipes

### default

Installs the fail2ban package, manages 2 templates: `/etc/fail2ban/fail2ban.conf` and `/etc/fail2ban/jail.conf`, and manages the fail2ban service.

## Attributes

This cookbook has a set of configuration options for fail2ban

- default['fail2ban']['loglevel'] = 'INFO'
- default['fail2ban']['logtarget'] = '/var/log/fail2ban.log'
- default['fail2ban']['syslogsocket'] = 'auto'
- default['fail2ban']['socket'] = '/var/run/fail2ban/fail2ban.sock'
- default['fail2ban']['pidfile'] = '/var/run/fail2ban/fail2ban.pid'
- default['fail2ban']['dbfile'] = '/var/lib/fail2ban/fail2ban.sqlite3'
- default['fail2ban']['dbpurgeage'] = 86_400

The `CRITICAL` and `NOTICE` log levels are only available on fail2ban >= 0.9.x. If they are used on a system with an older version of fail2ban, they will be mapped to `ERROR` and `INFO` respectively.

The `syslogsocket`, `dbfile`, and `dbpurgeage` options are only applicable to fail2ban >= 0.9.x

This cookbook has a set of configuration options for jail.conf

- default['fail2ban']['ignoreip'] = '127.0.0.1/8'
- default['fail2ban']['findtime'] = 600
- default['fail2ban']['bantime'] = 300
- default['fail2ban']['maxretry'] = 5
- default['fail2ban']['backend'] = 'polling'
- default['fail2ban']['email'] = 'root@localhost'
- default['fail2ban']['sendername'] = 'Fail2Ban'
- default['fail2ban']['action'] = 'action_'
- default['fail2ban']['banaction'] = 'iptables-multiport'
- default['fail2ban']['mta'] = 'sendmail'
- default['fail2ban']['protocol'] = 'tcp'
- default['fail2ban']['chain'] = 'INPUT'

This cookbook makes use of a hash to compile the jail.local-file and filter config files:

```
default['fail2ban']['services'] = {
  'ssh' => {
        "enabled" => "true",
        "port" => "ssh",
        "filter" => "sshd",
        "logpath" => node['fail2ban']['auth_log'],
        "maxretry" => "6"
     },
  'smtp' => {
        "enabled" => "true",
        "port" => "smtp",
        "filter" => "smtp",
        "logpath" => node['fail2ban']['auth_log'],
        "maxretry" => "6"
     }
}
```

The following attributes can be used per service:

- enabled
- port
- filter
- logpath
- maxretry
- protocol
- banaction
- bantime

Creating custom fail2ban filters:

```
default['fail2ban']['filters'] = {
  'nginx-proxy' => {
        "failregex" => ["^<HOST> -.*GET http.*"],
        "ignoreregex" => []
     },
}
```

In the case you would like to get Slack notifications on IP addresses banned/unbanned, this cookbook supports it by setting the following attributes:

```ruby
# A Slack webhook looks like this:
# https://hooks.slack.com/services/A123BCD4E/FG5HI6KLM/7n8opqrsT9UVWxyZ0AbCdefG
default['fail2ban']['slack_webhook'] = nil
# Then setting the Slack channel name without the hashtag (#)
default['fail2ban']['slack_channel'] = 'general'
```

Then you will get notifications like this:

> [hostname] Banned 🇳🇬 217.117.13.12 in the jail sshd after 5 attempts


## Resources

There are 2 resources you can use to create `fail2ban_filter` and `fail2ban_jail`.

### fail2ban_filter
The filter resource manages custom filters that are stored in `/etc/fail2ban/filters.d/`.

#### Parameters
fail2ban_filter accepts the following parameters:

* failregex
* ignoreregex

Example:

```
fail2ban_filter 'webmin-auth' do
  failregex ["^%(__prefix_line)sNon-existent login as .+ from <HOST>\s*$",
             "^%(__prefix_line)sInvalid login as .+ from <HOST>\s*$"]
end
```

### fail2ban_jail
The filter resource manages custom jail definitions that are stored in `/etc/fail2ban/jail.d/`.

### Parameters
fail2ban_jail accepts the following parameters:

* filter - Name of the filter to be used by the jail to detect matches.
* logpath -  Path to the log file which is provided to the filter 
* protocol - Protocol type [tcp, udp, all]. TCP Default.
* ports - An array of port(s) to watch.
* maxretry - Number of matches which triggers ban action.
* ignoreips - An array of IPs to ignore.

Example:

```
fail2ban_jail 'ssh' do
  ports %w(ssh)
  filter 'sshd'
  logpath node['fail2ban']['auth_log']
  maxretry 3
end
```

## Issues related to rsyslog

If you are using rsyslog parameter "$RepeatedMsgReduction on" in rsyslog.conf file
then you can get "Last message repeated N times" in system log file (for example auth.log).
Fail2ban will not work because the internal counter maxretry will not expand the repeated messages.
Change parameter "$RepeatedMsgReduction off" in rsyslog.conf file for maximum accuracy of failed login attempts.

This rsyslog parameter is default ON for ubuntu 12.04 LTS for example.

## License and Author

```
Author:: Joshua Timberman (<joshua@chef.io>)

Copyright:: 2009-2016, Chef Software, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
