class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  Devise.omniauth_configs.keys.each do |provider|
    #omni callback routes us to this action
    #this action will be automatically named as the omni provider [:github, :google_oauth2]
    define_method provider do
      #at this point the omni callback works and we get provider data
      auth = request.env['omniauth.auth']

      if auth.nil?
        redirect_to root_path, alert: "No data received. Please try again"
      else
        @user = User.from_omniauth(auth)
    
        if @user.persisted?
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: provider
          sign_in_and_redirect @user, event: :authentication
        else
          session['devise.github_data'] = auth.except('extra')
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
        end
      end
    end
  end

  def failure
    redirect_to root_path, alert: "Something went wrong. Please try again"
  end

end