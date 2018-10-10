#
# Cookbook Name:: fail2ban
# Resource:: fail2ban_filter
#
# Copyright 2015, OpenStreetMap Foundation
# Copyright 2018, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

property :filter, String, name_property: true
property :source, String, default: 'filter.erb'
property :cookbook, String, default: 'fail2ban'
property :failregex, [String, Array]
property :ignoreregex, [String, Array]

action :create do
  template "/etc/fail2ban/filter.d/#{new_resource.filter}.conf" do
    cookbook new_resource.cookbook
    source new_resource.filter
    owner 'root'
    group 'root'
    mode '0644'
    variables failregex: new_resource.failregex,
              ignoreregex: new_resource.ignoreregex
    notifies :reload, 'service[fail2ban]'
  end
end

action :delete do
  file "/etc/fail2ban/filter.d/#{new_resource.filter}.conf" do
    action :delete
    notifies :reload, 'service[fail2ban]'
  end
end
