# fail2ban_install

Installs or removes the fail2ban package.

## Actions

* `:install`: Installs fail2ban. Default.
* `:remove`: Removes fail2ban.

## Properties

* `package_name`: String or Array. Default: `'fail2ban'`. Package name or names to manage.
* `install_curl`: true or false. Default: `false`. Installs `curl` for Slack notification hooks.
* `manage_epel`: true or false. Default: RHEL family only. Includes `yum-epel` before package install.
* `manage_epel_next`: true or false. Default: disabled on CentOS Stream 10, enabled elsewhere. Controls EPEL Next repository management when `yum-epel` is included.

## Examples

```ruby
fail2ban_install 'default'
```

```ruby
fail2ban_install 'default' do
  install_curl true
end
```
