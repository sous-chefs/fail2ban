# frozen_string_literal: true

require 'spec_helper'

describe 'fail2ban_jail' do
  step_into :fail2ban_jail
  platform 'ubuntu', '24.04'

  context 'with create action' do
    recipe do
      fail2ban_service 'default' do
        action :nothing
      end

      fail2ban_jail 'ssh' do
        ports %w(ssh)
        filter 'sshd'
        logpath '/var/log/auth.log'
        maxretry 3
      end
    end

    it { is_expected.to create_template('/etc/fail2ban/jail.d/50-ssh.conf') }

    it do
      is_expected.to render_file('/etc/fail2ban/jail.d/50-ssh.conf')
        .with_content(/^maxretry = 3$/)
    end
  end

  context 'with delete action' do
    recipe do
      fail2ban_service 'default' do
        action :nothing
      end

      fail2ban_jail 'ssh' do
        action :delete
      end
    end

    it { is_expected.to delete_file('/etc/fail2ban/jail.d/50-ssh.conf') }
  end
end
