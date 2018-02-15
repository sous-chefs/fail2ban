# fail2ban Cookbook

[![Build Status](https://travis-ci.org/chef-cookbooks/fail2ban.svg?branch=master)](https://travis-ci.org/chef-cookbooks/fail2ban) [![Cookbook Version](https://img.shields.io/cookbook/v/fail2ban.svg)](https://supermarket.chef.io/cookbooks/fail2ban)

Installs and configures `fail2ban`, a utility that watches logs for failed login attempts and blocks repeat offenders with firewall rules. On Redhat systems this cookbook will enable the EPEL repository in order to retrieve the fail2ban package.

## Requirements

### Platforms

- Debian/Ubuntu
- RHEL/CentOS/Scientific/Amazon/Oracle
- Fedora
- OpenSUSE

### Chef
- Chef 12.9+

### Cookbooks

- yum-epel

## Recipes

### default

Installs the fail2ban package, manages 2 templates: `/etc/fail2ban/fail2ban.conf` and `/etc/fail2ban/jail.conf`, and manages the fail2ban service.

## Usage

Typically, include `recipe[fail2ban]` in a base role applied to all nodes.

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

Issues related to rsyslog
==========================

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
