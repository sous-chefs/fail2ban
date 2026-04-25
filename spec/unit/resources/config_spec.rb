# frozen_string_literal: true

require 'spec_helper'

describe 'fail2ban_config' do
  step_into :fail2ban_config
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      fail2ban_service 'default' do
        action :nothing
      end

      fail2ban_config 'default'
    end

    it { is_expected.to create_template('/etc/fail2ban/fail2ban.conf') }
    it { is_expected.to create_template('/etc/fail2ban/jail.local') }
    it { is_expected.to delete_file('/etc/fail2ban/jail.d/defaults-debian.conf') }
    it { is_expected.to_not create_template('/etc/fail2ban/action.d/slack.conf') }
    it { is_expected.to_not create_template('/etc/fail2ban/slack_notify.sh') }

    it do
      is_expected.to render_file('/etc/fail2ban/fail2ban.conf')
        .with_content(/^loglevel = INFO$/)
    end

    it do
      is_expected.to render_file('/etc/fail2ban/fail2ban.conf')
        .with_content(%r{^dbfile = /var/lib/fail2ban/fail2ban.sqlite3$})
    end

    it do
      is_expected.to render_file('/etc/fail2ban/jail.local')
        .with_content(/^action = %\(action_\)s$/)
    end
  end

  context 'with custom filters and Slack notifications' do
    recipe do
      fail2ban_service 'default' do
        action :nothing
      end

      fail2ban_config 'default' do
        filters(
          'nginx-proxy' => {
            'failregex' => ['^<HOST> -.*GET http.*'],
            'ignoreregex' => [],
          }
        )
        slack_channel 'infra'
        slack_webhook 'https://hooks.slack.com/services/A123BCD4E/FG5HI6KLM/7n8opqrsT9UVWxyZ0AbCdefG'
      end
    end

    it { is_expected.to create_template('/etc/fail2ban/filter.d/nginx-proxy.conf') }
    it { is_expected.to create_template('/etc/fail2ban/action.d/slack.conf') }
    it { is_expected.to create_template('/etc/fail2ban/slack_notify.sh').with(owner: 'root', group: 'root', mode: '0750') }

    it do
      is_expected.to render_file('/etc/fail2ban/jail.local')
        .with_content(/^action = %\(action_with_slack_notification\)s$/)
    end

    it do
      is_expected.to render_file('/etc/fail2ban/slack_notify.sh')
        .with_content(%r{^HOOK_URL=https://hooks.slack.com/services/A123BCD4E/FG5HI6KLM/7n8opqrsT9UVWxyZ0AbCdefG$})
    end
  end
end
