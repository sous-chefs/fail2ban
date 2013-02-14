Description
===========

Installs and configures `fail2ban`, a utility that watches logs for failed login attempts 
and blocks repeat offenders with firewall rules.

Requirements
============

Platform
--------

* Debian, Ubuntu
* RHEL/CentOS/Scientific


Recipes
=======

default
-------

Installs the fail2ban package, manages 2 templates: `/etc/fail2ban/fail2ban.conf` 
and `/etc/fail2ban/jail.conf`, and manages the fail2ban service.

redhat
------

Because fail2ban is not available in the redhat/centos repos, this recipe first
includes the yum::epel recipe, subscribing the host to the epel yum repository.
It then includes the default recipe and proceeds as normal.

Usage
=====

Typically, include `recipe[fail2ban]` in a base role applied to all nodes. For
RedHat-family hosts, include `recipe[fail2ban::redhat]` instead.

License and Author
==================

Author:: Joshua Timberman

Copyright:: 2009-2013, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
