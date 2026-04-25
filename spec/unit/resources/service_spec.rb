# frozen_string_literal: true

require 'spec_helper'

describe 'fail2ban_service' do
  step_into :fail2ban_service
  platform 'ubuntu', '24.04'

  context 'with enable and start actions' do
    recipe do
      fail2ban_service 'default' do
        action [:enable, :start]
      end
    end

    it { is_expected.to enable_service('fail2ban') }
    it { is_expected.to start_service('fail2ban') }
  end

  context 'with restart action' do
    recipe do
      fail2ban_service 'default' do
        action :restart
      end
    end

    it { is_expected.to restart_service('fail2ban') }
  end
end
