require 'spec_helper'

describe 'default recipe on CentOS 5' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '5.11')
    runner.node.normal['packages']['fail2ban'] = {
      epoch: '0',
      version: '0.8.14',
      release: '1.el5',
      installdate: '1409547600',
      arch: 'noarch',
    }
    runner.converge('fail2ban::default')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end

  it 'should template fail2ban.conf' do
    expect(chef_run).to render_file('/etc/fail2ban/fail2ban.conf').with_content(/^loglevel = 3/)
  end
end

describe 'default recipe on CentOS 6' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '6.9')
    runner.node.normal['packages']['fail2ban'] = {
      epoch: '0',
      version: '0.9.6',
      release: '1.el6.1',
      installdate: '1488348000',
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

describe 'default recipe on CentOS 7' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611')
    runner.node.normal['packages']['fail2ban'] = {
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
