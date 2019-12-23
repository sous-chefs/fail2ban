#
# Cookbook:: fail2ban
# Attributes:: default
#
# Copyright:: 2013-2018, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# fail2ban.conf configuration options
default['fail2ban']['loglevel'] = 'INFO'
default['fail2ban']['logtarget'] = '/var/log/fail2ban.log'
default['fail2ban']['syslogsocket'] = 'auto'
default['fail2ban']['socket'] = '/var/run/fail2ban/fail2ban.sock'
default['fail2ban']['pidfile'] = '/var/run/fail2ban/fail2ban.pid'
default['fail2ban']['dbfile'] = '/var/lib/fail2ban/fail2ban.sqlite3'
default['fail2ban']['dbpurgeage'] = 86_400

# jail.conf configuration options
default['fail2ban']['ignoreip'] = '127.0.0.1/8'
default['fail2ban']['findtime'] = 600
default['fail2ban']['bantime'] = 300
default['fail2ban']['maxretry'] = 5
default['fail2ban']['backend'] = 'polling'
default['fail2ban']['email'] = 'root@localhost'
default['fail2ban']['sendername'] = 'Fail2Ban'
default['fail2ban']['action'] = 'action_'
default['fail2ban']['banaction'] = 'iptables-multiport'
default['fail2ban']['mta'] = 'sendmail'
default['fail2ban']['protocol'] = 'tcp'
default['fail2ban']['chain'] = 'INPUT'
# Create and copy/past your Slack webhook in the following attribute and you'll
# get Slack message on banning/unbanning IP like this:
# [hostname] Banned 🇳🇬 217.117.13.12 in the jail sshd after 5 attempts
#
# A Slack webhook looks like this:
# https://hooks.slack.com/services/A123BCD4E/FG5HI6KLM/7n8opqrsT9UVWxyZ0AbCdefG
default['fail2ban']['slack_webhook'] = nil
# Then setting the Slack channel name without the hashtag (#)
default['fail2ban']['slack_channel'] = 'general'

# Using attributes to specify the fail2ban filters is now deprecated in favor
# of the fail2ban_filter resource which provides a more Chef native way of defining
# individual filters in recipes using resources
# format: { name: { failregex: '', ignoreregex: ''} }
default['fail2ban']['filters'] = {}

case node['platform_family']
when 'rhel', 'fedora', 'amazon'
  default['fail2ban']['auth_log'] = '/var/log/secure'
when 'debian'
  default['fail2ban']['auth_log'] = '/var/log/auth.log'
end

# Using attributes to specify the fail2ban jails is now deprecated in favor
# of the fail2ban_filter resource which provides a more Chef native way of defining
# individual filters in recipes using resources
default['fail2ban']['services'] = {
  'ssh' => {
    'enabled' => 'true',
    'port' => 'ssh',
    'filter' => 'sshd',
    'logpath' => node['fail2ban']['auth_log'],
    'maxretry' => '6',
  },
}

if platform_family?('rhel', 'fedora', 'amazon')
  default['fail2ban']['services']['ssh-iptables'] = {
    'enabled' => false,
  }
end
