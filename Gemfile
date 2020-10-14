source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem "rails", "~> 6.0.3.4"
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false

group :development do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

#multitenancy
gem 'devise'
gem 'simple_form'
gem 'devise_invitable', '~> 2.0.0'
gem 'acts_as_tenant'
gem 'friendly_id'

#storage
gem 'active_storage_validations' #tenant logo
gem "aws-sdk-s3", require: false

group :production do
  gem 'exception_notification'
end

gem 'invisible_captcha'

gem 'omniauth-google-oauth2'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'

#additional functionality for importing contacts from social accounts
gem "omnicontacts"

#i18n
gem 'rails-i18n', '~> 6.0.0' # For 6.0.0 or higher
