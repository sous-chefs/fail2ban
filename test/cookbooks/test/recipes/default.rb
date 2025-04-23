apt_update

node.default['fail2ban']['ignoreip'] =  %w(1.2.3.4 5.6.7.8)

include_recipe 'openssh'
include_recipe 'rsyslog'
include_recipe 'fail2ban'
