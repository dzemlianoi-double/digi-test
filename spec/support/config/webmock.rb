# frozen_string_literal: true

require 'webmock/rspec'

WebMock.disable_net_connect!(allow: 'chromedriver.storage.googleapis.com', allow_localhost: true)
