# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

gem 'bootsnap', require: false
gem 'kaminari', '~> 1.2', '>= 1.2.2'
gem 'net-http', '~> 0.4.0'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rack-cors'
gem 'rails', '~> 7.1.2'
gem 'rails-i18n', '~> 7.0', '>= 7.0.8'
gem 'rspec', '~> 3.4'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'
  gem 'factory_bot_rails', '~> 6.4'
  gem 'faker', '~> 3.2', '>= 3.2.2'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.3'
  gem 'rubocop', '~> 1.57', '>= 1.57.2'
end

group :test do
  gem 'database_cleaner-active_record', '~> 2.1'
end

group :development do
  gem 'rails-erd', '~> 1.5', '>= 1.5.2'
end
