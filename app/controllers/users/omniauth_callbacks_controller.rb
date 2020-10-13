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

        # we look for an identity and user that share this oauth data
        identity = User::Identity.find_by(provider: auth.provider, uid: auth.uid)
        user = User.find_by(email: auth.info.email)

        if user.present?
          if identity.present?
            identity.update(
              provider: auth.provider,
              uid: auth.uid,
              auth: auth.to_hash
              )
          else
            user.identities.create(
              provider: auth.provider,
              uid: auth.uid,
              auth: auth.to_hash
              )
          end
        else
          user = User.create(
             email: auth.info.email,
             password: Devise.friendly_token[0,20]
          )
          user.identities.create(
            provider: auth.provider,
            uid: auth.uid,
            auth: auth.to_hash
            )
        end

        user.skip_confirmation! #confirm account with social login

        user.provider = auth.provider #to see from which provider the user is logged in now
        user.image = auth.info.image
        user.name = auth.info.name

        if user.persisted?
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: provider
          sign_in_and_redirect user, event: :authentication
        else
          session['devise.github_data'] = auth.except('extra')
          redirect_to new_user_registration_url, alert: user.errors.full_messages.join("\n")
        end
      end
    end
  end

  def failure
    redirect_to root_path, alert: "Something went wrong. Please try again"
  end

end