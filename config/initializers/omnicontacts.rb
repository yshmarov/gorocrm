require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail,
    Rails.application.credentials.dig(:google, :id).to_s,
    Rails.application.credentials.dig(:google, :secret).to_s,
    # "#{Rails.application.credentials[:google][:id]}",
    # "#{Rails.application.credentials[:google][:secret]}",
    {redirect_path: "/contacts/gmail/contact_callback", max_results: 50}
end
