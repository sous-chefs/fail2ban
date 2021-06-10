require 'spec_helper'

describe 'default recipe on CentOS' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos')
    runner.node.default['packages']['fail2ban'] = {
      epoch: '0',
      version: '0.9.7',
      release: '1.el7',
      installdate: '1501563600',
      arch: 'noarch',
    }
    runner.converge('fail2ban::default')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end

  it 'should template fail2ban.conf' do
    expect(chef_run).to render_file('/etc/fail2ban/fail2ban.conf').with_content { |content|
      expect(content).to match(/^loglevel = INFO/)
      expect(content).to match(/^dbpurgeage = 86400/)
    }
  end
end
