# frozen_string_literal: true

require 'site_prism'
require 'site_prism/all_there'
require 'webmock/rspec'
require 'capybara/rspec'
require 'webdrivers/chromedriver'

Capybara.configure do |config|
  config.default_driver = ENV['CI'] ? :selenium_chrome_headless : :selenium_chrome
  config.javascript_driver = ENV['CI'] ? :selenium_chrome_headless : :selenium_chrome
  config.server = :puma, { Silent: true }
  config.default_max_wait_time = 10
end
