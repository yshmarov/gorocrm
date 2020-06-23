class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
  end

  #include SetTenant #set ActsAsTenant.current_tenant
  #include RequireTenant #no current_tenant = no access to entire controller

  def dashboard
    
  end

    set_current_tenant_through_filter #acts_as_tenant
    before_action :set_tenant, only: :dashboard
    
  
    def set_tenant
      if current_user
        if current_user.tenant_id.present?
          if current_user.tenants.include?(current_user.tenant)
            #current_account = Tenant.find_by(id: current_user.tenant_id) #does not require belongs_to relationship
            current_account = current_user.tenant #requires belongs_to relationship
            #User.find_by(email: "wawa@w.com").update_attributes!(tenant_id: 2)
            set_current_tenant(current_account)
          else
            set_current_tenant(nil)
          end
        else
          set_current_tenant(nil)
        end
      else
        set_current_tenant(nil)
      end
    end


end
