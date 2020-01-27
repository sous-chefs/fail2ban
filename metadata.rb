name 'fail2ban'
maintainer 'Sous-Chefs'
maintainer_email 'help@sous-chefs.org'
license 'Apache-2.0'
description 'Installs and configures fail2ban'
source_url 'https://github.com/chef-cookbooks/fail2ban'
issues_url 'https://github.com/chef-cookbooks/fail2ban/issues'
chef_version '>= 13.0'
version '6.2.0'

depends 'yum-epel'

%w(amazon centos debian fedora oracle redhat scientific ubuntu suse opensuseleap ).each do |os|
  supports os
end
