require 'spec_helper'

describe 'fail2ban::default converge' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.node.set['fail2ban']['filters'] = {
      'nginx-proxy' => {
        'failregex' => ['^<HOST> -.*GET http.*'],
        'ignoreregex' => []
      }
    }
    runner.converge('fail2ban::default')
  end

  it 'installs the fail2ban package' do
    expect(chef_run).to install_package('fail2ban')
  end

  it 'should start and enable service fail2ban' do
    expect(chef_run).to start_service('fail2ban')
    expect(chef_run).to enable_service('fail2ban')
  end

  it 'should template fail2ban.conf' do
    expect(chef_run).to render_file('/etc/fail2ban/fail2ban.conf')
  end

  it 'should template jail.local' do
    expect(chef_run).to render_file('/etc/fail2ban/jail.local')
  end

  it 'reload service on config change' do
    resource = chef_run.template('/etc/fail2ban/fail2ban.conf')
    expect(resource).to notify('service[fail2ban]').to(:restart)
  end

  it 'templates filter.d file when attribute set' do
    expect(chef_run).to render_file('/etc/fail2ban/filter.d/nginx-proxy.conf')
  end
end
