# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby(File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip)

gem 'rails', '~> 7.0.3'

# System
gem 'pg', '~> 1.4'
gem 'puma', '~> 5.6'

# Business logic handling
gem 'interactor', '~> 3.1'

# Authentication and authorization
gem 'devise', '~> 4.8'

# Views and Assets
gem 'draper', '~> 4.0'
gem 'hamlit', '~> 2.16'
gem 'pagy', '~> 5.10'
gem 'webpacker', '~> 5.4'

# Booting of app
gem 'bootsnap', '~> 1.12', require: false

# DB utils
gem 'seedbank', '~> 0.5'

group :development, :test do
  gem 'brakeman', '~> 5.2', require: false
  gem 'bundler-audit', '~> 0.9', require: false
  gem 'bundler-leak', '~> 0.3', require: false
  gem 'factory_bot_rails', '~> 6.2', require: false
  gem 'ffaker', '~> 2.21', require: false
  gem 'haml_lint', '~> 0.40', require: false
  gem 'lefthook', '~> 1.0', require: false
  gem 'pry', '~> 0.14'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rubocop', '~> 1.31', require: false
  gem 'rubocop-md', '~> 1.0', require: false
  gem 'rubocop-performance', '~> 1.14', require: false
  gem 'rubocop-rails', '~> 2.15', require: false
  gem 'rubocop-rspec', '~> 2.12', require: false
  gem 'traceroute', '~> 0.8'
end

group :development do
  gem 'annotate', '~> 3.2'
  gem 'listen', '~> 3.7'
end

group :test do
  gem 'rspec-rails', '~> 5.1'
  gem 'shoulda-matchers', '~> 5.1'
  gem 'simplecov', '~> 0.21', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 2.0', platforms: %i[mingw mswin x64_mingw jruby]
