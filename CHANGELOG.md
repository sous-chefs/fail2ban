# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 7.1.1 - *2025-09-04*

## 7.1.0 - *2025-04-30*

Allow `node['fail2ban']['ignoreip']` attribute be defined as either a String or an Array.

## 7.0.24 - *2024-11-18*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 7.0.23 - *2024-05-06*

## 7.0.22 - *2024-05-06*

## 7.0.21 - *2023-09-28*

## 7.0.20 - *2023-09-04*

## 7.0.19 - *2023-05-17*

## 7.0.18 - *2023-04-17*

## 7.0.17 - *2023-04-07*

Standardise files with files in sous-chefs/repo-management

## 7.0.16 - *2023-04-01*

## 7.0.15 - *2023-04-01*

## 7.0.14 - *2023-04-01*

Standardise files with files in sous-chefs/repo-management

## 7.0.13 - *2023-03-20*

Standardise files with files in sous-chefs/repo-management

## 7.0.12 - *2023-03-15*

Standardise files with files in sous-chefs/repo-management

## 7.0.11 - *2023-03-02*

Standardise files with files in sous-chefs/repo-management

## 7.0.10 - *2023-02-27*

Standardise files with files in sous-chefs/repo-management

## 7.0.9 - *2023-02-16*

Standardise files with files in sous-chefs/repo-management

## 7.0.8 - *2023-02-15*

## 7.0.7 - *2023-02-14*

Standardise files with files in sous-chefs/repo-management

## 7.0.6 - *2023-02-14*

## 7.0.5 - *2022-12-12*

Standardise files with files in sous-chefs/repo-management

## 7.0.4 - *2022-08-07*

- Document missing service attributes

## 7.0.3 - *2022-08-07*

- CI: Switch to shared lint-unit workflow

## 7.0.2 - *2022-02-17*

- Standardise files with files in sous-chefs/repo-management
- Remove delivery folder

## 7.0.1 - *2021-08-30*

- Standardise files with files in sous-chefs/repo-management

## 7.0.0 - *2021-06-19*

- Chef 17 updates: enable `unified_mode` on all resources
- Bump required Chef Infra Client to >= 15.3
- Add `bantime` property to `fail2ban_jail` resource
- Remove unsupported platforms
- Remove logic for fail2ban < 0.9

## 6.3.3 - *2021-06-01*

- Standardise files with files in sous-chefs/repo-management

## 6.3.2 - *2021-02-26*

- Fix jail template to not set `port` or `logpath` if not defined in the resource

## 6.3.1 - *2020-12-09*

- improves resource documentation in README
- fixes jail resource to support priority property in delete action

## 6.3.0 - *2020-12-01*

- Remove deprecated platform in spec tests
- fixed wrong property in `fail2ban_jail` and `fail2ban_filter` resources
- added documentation for above changes

## 6.2.1 (2020-05-05)

- Migrated build system to github actions for testing

## 6.2.0 (2020-01-26)

- Simplify platform check logic
- Fix several parts of the recipe that were not compatible with Amazon Linux
- Update all templates to use the same managed by chef warning

## 6.1.0 (2019-10-16)

- Adds Slack notifications as a notifier
- Fixup testing

## 6.0.0 (2019-05-08)

- Require Chef 13 or later
- Add support for Amazon Linux on Chef 13+
- Add support for Ubuntu 18.04
- Add new fail2ban_jail and fain2ban_filter resources that allow you to define individual filters and jails within your own recipes instead of using the monolithic attribute config. With the introduction of these resources the existing attribute driven workflow has been deprecated and will eventually be removed. Thank you OpenStreetMap for these great new resources.

## 5.0.2 (2018-07-18)

- Update specs to the latest platform versions
- Testing updates
- Delete jail.d/00-firewalld.conf on CentOS like we delete jail.d/defaults-debian.conf on Ubuntu)
- Move templates out of the default directory

## 5.0.1 (2018-02-15)

- Update the minimum supported Chef release to 12.9 since we're using the Ohai package plugin now. We highly recommend you run at least the very latest Chef 12 reelase which includes additional packabe plugin fixes.

## 5.0.0 (2018-02-14)

- Add new logic to detect the fail2ban version and apply appropriate config for 0.8 vs > 0.8. This makes sure we're using the current on newer systems while still supporting Ubuntu 14.04
- Remove defunct syslog config statements from very old fail2ban releases

## 4.0.1 (2017-04-26)

- Update apache2 license string

## 4.0.0 (2017-03-14)

**NOTE** The next version of this cookbook will be a rewrite to use custom resources and eliminate attributes. This should be backwards compatible to previous versions of the cookbook, but there are some changes that might break current assumptions so doing a major bump.

- [#33] Fix ubuntu platforms
- Add ubuntu platform guards to default recipe
- Update README to be more clear with regards to rsyslog
- Remove defaults-debian.conf on ubuntu platforms, that assumes ssh enabled on nodes.
- Modify metadata dependency to Chef 12.5+
- Modify chef spec to remove service start, enable on resources as on debian platforms the service is started by install of package
- Make test kitchen show deprecation errors
- Remove EOL debian and ubuntu logic from default recipe

## 3.1.0 (2016-11-14)

- Add support for jail ignorecommand

## 3.0.0 (2016-09-16)

- Testing updates
- Require Chef 12.1+
- Add opensuse and opensuseleap to the metadata

## v2.3.1 (2016-07-20)

- Added fixture cookbook
- Cleanup of kitchen configurations
- [#38] Default config values to avoid warning from pbanderas
- [#37] Add support for 'sendername' setting on config from Restless-ET
- [#35] Add support for configuring service backend from ares
- many updates to testing
- [#25] Allow jail actions of either format from rchekaluk
- Add OpenSUSE platform

## v2.3.0 (2015-08-22)

- Updated Berksfile to 3.0 format
- Added "generated by chef" comment headers to all templates
- Added missing bantime service attribute to the readme
- Resolved all rubocop warnings
- Added yum-epel to the readme as a dependency
- Removed the dependency on the yum cookbook. This cookbook only requires yum-epel, which handles the yum dependency
- Added a chefignore file to prevent unnecessary files from being uploaded to the chef-server
- Changed fail2ban package to install only vs. upgrading. Administrators should be able to choose when packages are upgraded
- Change file mode definitions to be strings to preserve the leading zeros
- Added testing / cookbook version badges to the readme
- Added source_url and issues_url metadata for Chef 12
- Add basic cookbook convergence chefspec tests
- Updated the testing and contributing docs to more recent versions
- Bumped all development and testing gems to the latest versions
- Expanded Travis testing to ruby 2/2.1/2.2
- Changed Opscode to Chef Software in all locations

## v2.2.1 (2014-10-15)

- [#24] Add default value for pidfile

## v2.2.0

- 15 - Fix small typo in README.md for smtp

- 16 - Support custom fail2ban filters

- 21 - Service and defaults improvements, Fedora support

## v2.1.2

### Improvement

- Allow action override in service block

## v2.1.0

Updating for cookbook yum ~> 3.0 Fixing style or rubocop Updating test bits

## v2.0.4

fixing metadata version error. locking to 3.0

## v2.0.2

Locking yum dependency to '< 3'

## v2.0.0

[COOK-2530] Allow customisation of jail.local

## v1.2.4

### New Feature

- Add clarifying caveat about rsyslog in README

### Bug

- Fix default `jail.conf` on CentOS

### Improvement

- Handle `/etc.init.d/fail2ban status` for older versions

## v1.2.2

### Bug

- [COOK-2588]: Fail2ban needs to store the socket in the correct location
- [COOK-2592]: fail2ban: Update jail file template to match current config file

## v1.2.0

- [COOK-2292] - Add fail2ban support for RHEL using EPEL
- [COOK-2426] - Fail2ban cookbook needs syslog tunables in config file
- Development repository only: test kitchen 1.0.alpha support

## v1.1.0

- [COOK-2291] - Add additional tunables to the fail2ban cookbook

## v1.0.2

- [COOK-2217] - Users should be able to configure the email address fail2ban uses to send messages

## v1.0.0

- Current public release.
