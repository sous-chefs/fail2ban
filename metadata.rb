name 'fail2ban'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs and configures fail2ban'

version '6.0.0'

depends 'yum-epel'

%w(amazon centos debian fedora oracle redhat scientific ubuntu suse opensuse opensuseleap ).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/fail2ban'
issues_url 'https://github.com/chef-cookbooks/fail2ban/issues'
chef_version '>= 13.0'
