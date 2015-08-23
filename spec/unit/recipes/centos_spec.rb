require 'spec_helper'

describe 'default recipe on CentOS 5' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'centos', version: '5.11').converge('fail2ban::default')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end

describe 'default recipe on CentOS 6' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'centos', version: '6.6').converge('fail2ban::default')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end

describe 'default recipe on CentOS 7' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'centos', version: '7.1').converge('fail2ban::default')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
