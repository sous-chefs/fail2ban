require 'spec_helper'

describe 'default recipe on Ubuntu 12.04' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '12.04').converge('fail2ban::default')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end

describe 'default recipe on Ubuntu 14.04' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04').converge('fail2ban::default')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
