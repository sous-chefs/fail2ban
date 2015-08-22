name 'fail2ban'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache 2.0'
description 'Installs and configures fail2ban'
version '2.3.0'

recipe 'default', 'Installs and configures fail2ban'

depends 'yum-epel'

%w(debian ubuntu redhat centos scientific amazon oracle fedora).each do |os|
  supports os
end

source_url 'https://github.com/opscode-cookbooks/fail2ban' if respond_to?(:source_url)
issues_url 'https://github.com/opscode-cookbooks/fail2ban/issues'  if respond_to?(:issues_url)
