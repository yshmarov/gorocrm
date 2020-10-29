module RequireTenant
  extend ActiveSupport::Concern

  included do

    before_action :require_tenant
    #if no tenant is set results are unscoped (acts_as_tenant)
    #this is required for all models that will be using acts_as_tenant(:tenant)
    #info: https://github.com/ErwinM/acts_as_tenant#scoping-your-models
    def require_tenant
      if ActsAsTenant.current_tenant.nil?
        redirect_to root_path, alert: "No tenant set!"
      end

      #require subscription to access all tenanted info
      unless ActsAsTenant.current_tenant.subscription.present?
        redirect_to pricing_path, alert: "Please select a plan to access the app"
      end

      #require ACTIVE subscription to access all tenanted info
      if ActsAsTenant.current_tenant.subscription.present?
        unless ActsAsTenant.current_tenant.subscription.active?
          redirect_to tenant_path(ActsAsTenant.current_tenant), alert: "Please resume your subscription"
        end
      end

    end

  end

end