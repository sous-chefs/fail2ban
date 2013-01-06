#
# Author:: Jordi Llonch <llonchj@gmail.com>
# Cookbook Name:: fail2ban
# Attributes:: fail2ban
#

case platform
when "fedora"
  default['fail2ban']['socket'] = '/var/run/fail2ban/fail2ban.sock'
  default['fail2ban']['logtarget'] = 'SYSLOG'
else
  default['fail2ban']['socket'] = '/tmp/fail2ban.sock'
  default['fail2ban']['logtarget'] = '/var/log/fail2ban.log'
end

default['fail2ban']['loglevel'] = 3
