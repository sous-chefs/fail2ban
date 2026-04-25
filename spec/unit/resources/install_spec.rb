# frozen_string_literal: true

require 'spec_helper'

describe 'fail2ban_install' do
  step_into :fail2ban_install
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      fail2ban_install 'default'
    end

    it { is_expected.to install_package('fail2ban') }
    it { is_expected.to_not install_package('curl') }
    it { is_expected.to nothing_ohai('reload package list') }
  end

  context 'with Slack curl dependency enabled' do
    recipe do
      fail2ban_install 'default' do
        install_curl true
      end
    end

    it { is_expected.to install_package('curl') }
  end
end
