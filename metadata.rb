name              "fail2ban"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs and configures fail2ban"
version           "1.2.0"

recipe "fail2ban", "Installs and configures fail2ban"

%w{ redhat centos scientific ubuntu debian }.each do |os|
  supports os
end

%w{ yum }.each do |cb|
  depends cb
end