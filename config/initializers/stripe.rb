if Rails.application.credentials[Rails.env.to_sym].present? && Rails.application.credentials[Rails.env.to_sym][:stripe].present?
  Rails.configuration.stripe = {
    publishable_key: Rails.application.credentials[Rails.env.to_sym][:stripe][:public],
    secret_key: Rails.application.credentials[Rails.env.to_sym][:stripe][:secret]
  }
  Stripe.api_key = Rails.application.credentials[Rails.env.to_sym][:stripe][:secret]
end
