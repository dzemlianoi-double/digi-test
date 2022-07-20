# frozen_string_literal: true

require 'factory_bot_rails'

FactoryBot.create_list(:user, 10, password: 'password')
UserBankAccount.update_all(balance: 1_000_000) # rubocop:disable Rails/SkipsModelValidations
