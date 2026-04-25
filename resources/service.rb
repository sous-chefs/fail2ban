# frozen_string_literal: true

provides :fail2ban_service
unified_mode true

property :service_name, String, default: 'fail2ban'
property :supports, Hash, default: { status: true, restart: true }

%i(enable disable start stop restart reload).each do |service_action|
  action service_action do
    service new_resource.service_name do
      supports new_resource.supports
      action service_action
    end
  end
end
