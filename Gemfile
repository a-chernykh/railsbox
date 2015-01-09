source 'https://rubygems.org'
source 'https://rails-assets.org'

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

gem 'rails-assets-angular'
gem 'rails-assets-angular-classy'

gem 'sdoc', '~> 0.4.0', group: :doc

gem 'tilt'
gem 'rubyzip', require: 'zip'

gem 'browser'

gem 'unicorn'

group :development do
  gem 'spring'
  gem 'quiet_assets'
  gem 'guard-rspec', require: false
  gem 'guard-rake'
  gem 'terminal-notifier-guard'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'fakefs', require: 'fakefs/safe'
  gem 'shoulda-matchers', require: false
  gem 'database_cleaner'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'pry-byebug'
end
