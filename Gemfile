source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "rails", "~> 6.1.0"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.1"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 4.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "bootsnap", ">= 1.4.2", require: false

group :development do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "standard" # automatically format code to be inline with guidelines
  gem "annotate"
end

# multitenancy
gem "devise"
gem "simple_form"
gem "devise_invitable", "~> 2.0.0"
gem "acts_as_tenant"
gem "friendly_id"

# storage
gem "active_storage_validations" # tenant logo
gem "aws-sdk-s3", require: false

group :production do
  gem "exception_notification"
end

gem "invisible_captcha"

gem "omniauth-google-oauth2"
gem "omniauth-github"
gem "omniauth-twitter"
gem 'omniauth-facebook'

# additional functionality for importing contacts from social accounts
gem "omnicontacts"

# i18n
gem "rails-i18n", "~> 6.0.0" # For 6.0.0 or higher
gem "devise-i18n"

gem "stripe"

gem "ransack", github: "activerecord-hackery/ransack"

gem "simple_calendar", "~> 2.4"
gem 'money-rails', '~>1.12'
gem 'public_activity'
gem 'pagy', '~> 3.5'
