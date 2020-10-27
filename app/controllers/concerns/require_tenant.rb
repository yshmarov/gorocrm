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

      unless ActsAsTenant.current_tenant.subscription.present?
        redirect_to plans_path, alert: "Please select a plan to access the app"
      end

    end

  end

end