# fail2ban_service

Manages the fail2ban service.

## Actions

* `:enable`: Enables the service. Default.
* `:disable`: Disables the service.
* `:start`: Starts the service.
* `:stop`: Stops the service.
* `:restart`: Restarts the service.
* `:reload`: Reloads the service.
* `:nothing`: Declares the notification target without immediate action.

## Properties

* `service_name`: String. Default: `'fail2ban'`. Service name.
* `supports`: Hash. Default: `{ status: true, restart: true }`. Service support flags.

## Examples

```ruby
fail2ban_service 'default' do
  action [:enable, :start]
end
```
