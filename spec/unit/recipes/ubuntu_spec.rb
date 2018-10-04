require 'spec_helper'

describe 'default recipe on Ubuntu 12.04' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
    runner.node.normal['packages']['fail2ban'] = { version: '0.8.6-3wheezy3build0.12.04.1', arch: 'all' }
    runner.converge('fail2ban::default')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end

  it 'should template fail2ban.conf' do
    expect(chef_run).to render_file('/etc/fail2ban/fail2ban.conf').with_content(/^loglevel = 3/)
  end
end

describe 'default recipe on Ubuntu 14.04' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04')
    runner.node.normal['packages']['fail2ban'] = { version: '0.8.11-1', arch: 'all' }
    runner.converge('fail2ban::default')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end

  it 'should template fail2ban.conf' do
    expect(chef_run).to render_file('/etc/fail2ban/fail2ban.conf').with_content(/^loglevel = 3/)
  end
end

describe 'default recipe on Ubuntu 18.04' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '18.04')
    runner.node.normal['packages']['fail2ban'] = { version: '0.10.2-2', arch: 'all' }
    runner.converge('fail2ban::default')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end

  it 'should template fail2ban.conf' do
    expect(chef_run).to render_file('/etc/fail2ban/fail2ban.conf').with_content { |content|
      expect(content).to match(/^loglevel = INFO/)
      expect(content).to match(/^syslogsocket = auto/)
      expect(content).to match(%r{^dbfile = /var/lib/fail2ban/fail2ban.sqlite3})
      expect(content).to match(/^dbpurgeage = 86400/)
    }
  end
end
