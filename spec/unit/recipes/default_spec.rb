require 'spec_helper'

describe 'fail2ban::default converge' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
    runner.node.normal['fail2ban']['filters'] = {
      'nginx-proxy' => {
        'failregex' => ['^<HOST> -.*GET http.*'],
        'ignoreregex' => [],
      },
    }
    runner.converge('fail2ban::default')
  end

  it 'installs the fail2ban package' do
    expect(chef_run).to install_package('fail2ban')
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

# Note: To see this list just run 'sudo iptables --list-rules' on the vagrant instance
describe iptables do
  it { should have_rule('-P INPUT ACCEPT') }
  it { should have_rule('-P FORWARD ACCEPT') }
  it { should have_rule('-P OUTPUT ACCEPT') }
  it { should have_rule('-A INPUT -p tcp -m conntrack --ctstate RELATED,ESTABLISHED -m tcp --dport 22 -j ACCEPT')}
end
