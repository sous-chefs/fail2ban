# frozen_string_literal: true

require 'spec_helper'

describe 'fail2ban_filter' do
  step_into :fail2ban_filter
  platform 'ubuntu', '24.04'

  context 'with create action' do
    recipe do
      fail2ban_service 'default' do
        action :nothing
      end

      fail2ban_filter 'webmin-auth' do
        failregex ['^%(__prefix_line)sInvalid login as .+ from <HOST>\s*$']
        ignoreregex []
      end
    end

    it { is_expected.to create_template('/etc/fail2ban/filter.d/webmin-auth.conf') }
  end

  context 'with delete action' do
    recipe do
      fail2ban_service 'default' do
        action :nothing
      end

      fail2ban_filter 'webmin-auth' do
        action :delete
      end
    end

    it { is_expected.to delete_file('/etc/fail2ban/filter.d/webmin-auth.conf') }
  end
end
