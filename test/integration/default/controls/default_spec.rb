# frozen_string_literal: true

control 'fail2ban-service-01' do
  impact 1.0
  title 'Fail2ban service is enabled and running'

  describe service('fail2ban') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'fail2ban-config-01' do
  impact 1.0
  title 'Fail2ban jail.local is managed'

  describe file('/etc/fail2ban/jail.local') do
    it { should exist }
    its(:size) { should > 0 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its(:mode) { should cmp '0644' }
    its('content') { should match /^ignoreip = 1\.2\.3\.4\s5\.6\.7\.8$/ }
  end
end
