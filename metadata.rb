name 'fail2ban'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs and configures fail2ban'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '5.0.2'

recipe 'default', 'Installs and configures fail2ban'

depends 'yum-epel'

%w(amazon centos debian fedora oracle redhat scientific ubuntu suse opensuse opensuseleap ).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/fail2ban'
issues_url 'https://github.com/chef-cookbooks/fail2ban/issues'
chef_version '>= 13.0'
