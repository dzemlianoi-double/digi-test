# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby(File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip)

gem 'rails', '~> 7.0.3'

gem 'pg', '~> 1.4'
gem 'puma', '~> 5.6'

gem 'bootsnap', '~> 1.12', require: false

group :development, :test do
  gem 'brakeman', '~> 5.2', require: false
  gem 'bundler-audit', '~> 0.9', require: false
  gem 'bundler-leak', '~> 0.3', require: false
  gem 'haml_lint', '~> 0.40', require: false
  gem 'lefthook', '~> 1.0', require: false
  gem 'pry', '~> 0.14'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rubocop', '~> 1.31', require: false
  gem 'rubocop-performance', '~> 1.14', require: false
  gem 'rubocop-rails', '~> 2.15', require: false
  gem 'traceroute', '~> 0.8', require: false
end

group :development do
  gem 'listen', '~> 3.7'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 2.0', platforms: %i[mingw mswin x64_mingw jruby]
