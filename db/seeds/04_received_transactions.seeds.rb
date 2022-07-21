# frozen_string_literal: true

# Received transactions

require 'factory_bot_rails'

RECEIVED_TRANSACTIONS_COUNT = 20
current_user = User.find_by(email: 'user@example.com')
users = User.where.not(id: current_user.id)
bank_account = current_user.bank_account.reload

RECEIVED_TRANSACTIONS_COUNT.times do
  received_amount = rand(1..10_000)
  sender_bank_account = users.sample.bank_account

  cached_sender_balance = sender_bank_account.balance - received_amount
  cached_receiver_balance = bank_account.balance + received_amount

  FactoryBot.create(
    :money_transaction,
    amount: received_amount,
    cached_sender_balance:,
    cached_receiver_balance:,
    sender_bank_account:,
    receiver_bank_account: bank_account
  )
end
