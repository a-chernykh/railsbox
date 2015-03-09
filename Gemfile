source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2'

gem 'pg'

gem 'bootstrap-sass', '~> 3.3.1'
gem 'autoprefixer-rails'
gem 'sass-rails', '~> 4.0.3'
gem 'slim-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem "i18n-js", ">= 3.0.0.rc8"

source 'https://rails-assets.org' do
  gem 'rails-assets-angular'
end

gem 'sdoc', '~> 0.4.0', group: :doc

gem 'tilt'
gem 'rubyzip', require: 'zip'

gem 'browser'

gem 'unicorn'
gem 'rollbar', '~> 1.4.4'

group :development do
  gem 'spring'
  gem 'quiet_assets'
  gem 'guard-rspec', require: false
  gem 'guard-shell'
  gem 'terminal-notifier-guard'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'database_cleaner'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'pry-byebug'
end
