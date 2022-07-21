# frozen_string_literal: true

require 'factory_bot_rails'

# Random users
USERS_COUNT = 10

FactoryBot.create_list(:user, USERS_COUNT, password: 'password') if User.count == 1
