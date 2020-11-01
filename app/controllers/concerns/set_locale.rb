module SetLocale
  extend ActiveSupport::Concern

  included do
    before_action :set_locale

    private

    def set_locale
      if params["locale"].present?
        language = params["locale"].to_sym
        session["locale"] = language
        if user_signed_in?
          current_user.update(language: language)
          redirect_to user_path(current_user)
        else
          # redirect to previous page OR root
          redirect_to(request.referrer || root_path)
        end
      elsif session["locale"].present?
        language = session["locale"]
      else
        language = I18n.default_locale
      end

      if user_signed_in? && current_user.language.present?
        language = current_user.language
      end

      I18n.locale = if I18n.available_locales.map(&:to_s).include?(language)
        language
      else
        I18n.default_locale
      end
    end
  end
end
