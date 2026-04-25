# fail2ban_jail

Manages a fail2ban jail in `/etc/fail2ban/jail.d/`.

## Actions

* `:create`: Creates the jail. Default.
* `:delete`: Deletes the jail.

## Properties

* `jail`: String. Name property. Jail name.
* `bantime`: Integer or String. Default: `nil`. Ban duration.
* `cookbook`: String. Default: `'fail2ban'`. Template cookbook.
* `filter`: String. Default: `nil`. Filter used by the jail.
* `ignoreips`: Array. Default: `nil`. IPs or CIDRs to ignore.
* `logpath`: String. Default: `nil`. Log path watched by the jail.
* `maxretry`: Integer. Default: `nil`. Retry limit before banning.
* `ports`: Array. Default: `[]`. Ports watched by the jail.
* `priority`: String or Integer. Default: `'50'`. File priority prefix.
* `protocol`: String. Default: `nil`. Protocol, such as `tcp`, `udp`, or `all`.
* `source`: String. Default: `'jail.erb'`. Template source.
* `service_resource`: String. Default: `'fail2ban_service[default]'`. Resource notified on changes.

## Examples

```ruby
fail2ban_jail 'ssh' do
  ports %w(ssh)
  filter 'sshd'
  logpath '/var/log/auth.log'
  maxretry 3
end
```
