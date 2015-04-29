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
gem 'angular-rails-templates'
gem 'ngannotate-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-angular', '~> 1.3.15'
  gem 'rails-assets-ng-file-upload', '~> 3.2.4'
  gem 'rails-assets-ng-file-upload-shim', '~> 3.2.4'
end

gem 'tilt'
gem 'rubyzip', require: 'zip'

gem 'browser'

gem 'unicorn'
gem 'rollbar', '~> 1.4.4'

gem 'parser'

group :development do
  gem 'thin'

  gem 'spring'
  gem 'quiet_assets'

  gem 'guard-rspec', require: false
  gem 'guard-shell', require: false
  gem 'terminal-notifier-guard', require: false
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'database_cleaner'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'fuubar'

  gem "codeclimate-test-reporter", require: nil
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'pry-byebug'
end
