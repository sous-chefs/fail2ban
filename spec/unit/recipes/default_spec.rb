require 'spec_helper'

describe 'fail2ban::default converge' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu')
    runner.node.default['fail2ban']['filters'] = {
      'nginx-proxy' => {
        'failregex' => ['^<HOST> -.*GET http.*'],
        'ignoreregex' => [],
      },
    }
    runner.node.default['packages']['fail2ban'] = {
      version: '0.9.3-1',
      arch: 'all',
    }

    runner.converge('fail2ban::default')
  end

  it 'installs the fail2ban package' do
    expect(chef_run).to install_package('fail2ban')
  end

  it 'should not install the curl package' do
    expect(chef_run).to_not install_package('curl')
  end

  it 'should template fail2ban.conf' do
    expect(chef_run).to render_file('/etc/fail2ban/fail2ban.conf').with_content { |content|
      expect(content).to match(/^loglevel = INFO/)
      expect(content).to match(/^dbpurgeage = 86400/)
    }
  end

  it 'should template jail.local with the default action' do
    expect(chef_run).to render_file('/etc/fail2ban/jail.local').with_content { |content|
      expect(content).to match(/^action = %\(action_\)s/)
    }
  end

  it 'reload service on config change' do
    resource = chef_run.template('/etc/fail2ban/fail2ban.conf')
    expect(resource).to notify('service[fail2ban]').to(:restart)
  end

  # it 'templates filter.d file when attribute set' do
  #   expect(chef_run).to render_file('/etc/fail2ban/filter.d/nginx-proxy.conf')
  # end

  it 'should not templates action.d file' do
    expect(chef_run).to_not render_file('/etc/fail2ban/action.d/slack.conf')
  end

  it 'should not templates slack script file' do
    expect(chef_run).to_not render_file('/etc/fail2ban/slack_notify.sh')
  end
end

describe 'fail2ban::default converge with a given slack webhook' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu')
    runner.node.default['fail2ban'] = {
      filters: {
        'nginx-proxy' => {
          'failregex' => ['^<HOST> -.*GET http.*'],
          'ignoreregex' => [],
        },
      },
      slack_channel: 'infra',
      slack_webhook: 'https://hooks.slack.com/services/A123BCD4E/FG5HI6KLM/7n8opqrsT9UVWxyZ0AbCdefG',
    }
    runner.node.default['packages']['fail2ban'] = {
      version: '0.9.3-1',
      arch: 'all',
    }

    runner.converge('fail2ban::default')
  end

  it 'installs the fail2ban package' do
    expect(chef_run).to install_package('fail2ban')
  end

  # it 'should install the curl package' do
  #   expect(chef_run).to install_package('curl')
  # end

  it 'should template fail2ban.conf' do
    expect(chef_run).to render_file('/etc/fail2ban/fail2ban.conf').with_content { |content|
      expect(content).to match(/^loglevel = INFO/)
      expect(content).to match(/^dbpurgeage = 86400/)
    }
  end

  # it 'should template jail.local with the Slack action' do
  #   expect(chef_run).to render_file('/etc/fail2ban/jail.local').with_content { |content|
  #     expect(content).to match(/^action_with_slack_notification =/)
  #     expect(content).to match(/^\s+slack\[name=%\(__name__\)s\]/)
  #     expect(content).to match(/^action = %\(action_with_slack_notification\)s/)
  #   }
  # end

  it 'reload service on config change' do
    resource = chef_run.template('/etc/fail2ban/fail2ban.conf')
    expect(resource).to notify('service[fail2ban]').to(:restart)
  end

  # it 'should templates filter.d file when attribute set' do
  #   expect(chef_run).to render_file('/etc/fail2ban/filter.d/nginx-proxy.conf')
  # end

  # it 'should templates action.d file' do
  #   expect(chef_run).to render_file('/etc/fail2ban/action.d/slack.conf')
  # end

  # it 'should templates slack script file' do
  #   expect(chef_run).to render_file('/etc/fail2ban/slack_notify.sh').with_content { |content|
  #     expect(content).to match(%r{HOOK_URL=https://hooks.slack.com/services/A123BCD4E/FG5HI6KLM/7n8opqrsT9UVWxyZ0AbCdefG})
  #     expect(content).to match(/CHANNEL="#infra"/)
  #   }
  # end

  # it 'should create the slack script with the correct attributes' do
  #   expect(chef_run).to create_template('/etc/fail2ban/slack_notify.sh').with(
  #     owner: 'root',
  #     group: 'root',
  #     mode: '0755'
  #   )
  # end
end
