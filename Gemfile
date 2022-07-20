source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby(File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip)

gem 'rails', '~> 7.0.3'

gem 'pg', '~> 1.4'
gem 'puma', '~> 5.6'

gem 'bootsnap', '~> 1.12', require: false

group :development, :test do
  gem 'pry-byebug', '~> 3.9'
  gem 'pry-rails', '~> 0.3.9'
end

group :development do
  gem 'listen', '~> 3.7'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 2.0', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
