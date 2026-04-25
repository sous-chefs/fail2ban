# fail2ban_filter

Manages a fail2ban filter in `/etc/fail2ban/filter.d/`.

## Actions

* `:create`: Creates the filter. Default.
* `:delete`: Deletes the filter.

## Properties

* `filter`: String. Name property. Filter name.
* `source`: String. Default: `'filter.erb'`. Template source.
* `cookbook`: String. Default: `'fail2ban'`. Template cookbook.
* `failregex`: String or Array. Default: `nil`. Regular expressions matching failures.
* `ignoreregex`: String or Array. Default: `nil`. Regular expressions to ignore.
* `service_resource`: String. Default: `'fail2ban_service[default]'`. Resource notified on changes.

## Examples

```ruby
fail2ban_filter 'webmin-auth' do
  failregex ['^%(__prefix_line)sInvalid login as .+ from <HOST>\s*$']
end
```
