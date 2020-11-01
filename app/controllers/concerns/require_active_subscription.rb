module RequireActiveSubscription
  extend ActiveSupport::Concern

  included do
    before_action :require_active_subscription
    def require_active_subscription
      # require subscription to access all tenanted info
      unless ActsAsTenant.current_tenant.subscription.present?
        redirect_to pricing_path, alert: "Please select a plan to access the app"
      end

      # require ACTIVE subscription to access all tenanted info
      if ActsAsTenant.current_tenant.subscription.present?
        unless ActsAsTenant.current_tenant.subscription.active?
          redirect_to tenant_path(ActsAsTenant.current_tenant), alert: "Please resume your subscription"
        end
      end
    end
  end
end
