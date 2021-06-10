#
# Cookbook:: fail2ban
# Resource:: fail2ban_jail
#
# Copyright:: 2015, OpenStreetMap Foundation
# Copyright:: 2018, Chef Software, Inc.
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

property :bantime, [Integer, String]
property :cookbook, String, default: 'fail2ban'
property :filter, String
property :ignoreips, Array
property :jail, String, name_property: true
property :logpath, String
property :maxretry, Integer
property :ports, Array, default: []
property :priority, [String, Integer], default: '50'
property :protocol, String
property :source, String, default: 'jail.erb'

unified_mode true

action :create do
  template "/etc/fail2ban/jail.d/#{new_resource.priority}-#{new_resource.jail}.conf" do
    cookbook new_resource.cookbook
    source new_resource.source
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      bantime: new_resource.bantime,
      filter: new_resource.filter,
      ignoreips: new_resource.ignoreips,
      logpath: new_resource.logpath,
      maxretry: new_resource.maxretry,
      name: new_resource.jail,
      ports: new_resource.ports,
      protocol: new_resource.protocol
    )
    notifies :reload, 'service[fail2ban]'
  end
end

action :delete do
  file "/etc/fail2ban/jail.d/#{new_resource.priority}-#{new_resource.jail}.conf" do
    action :delete
    notifies :reload, 'service[fail2ban]'
  end
end
