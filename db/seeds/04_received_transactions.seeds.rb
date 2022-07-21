# frozen_string_literal: true

# Received transactions

require 'factory_bot_rails'

RECEIVED_TRANSACTIONS_COUNT = 20

current_user = User.find_by(email: 'user@example.com')
users = User.where.not(id: current_user.id)
bank_account = current_user.bank_account.reload

RECEIVED_TRANSACTIONS_COUNT.times do
  received_amount_in_cents = rand(1..100_000)
  sender_bank_account = users.sample.bank_account

  cached_sender_balance_in_cents = sender_bank_account.reload.balance_in_cents - received_amount_in_cents
  cached_receiver_balance_in_cents = bank_account.reload.balance_in_cents + received_amount_in_cents

  FactoryBot.create(
    :money_transaction,
    amount_in_cents: received_amount_in_cents,
    cached_sender_balance_in_cents:,
    cached_receiver_balance_in_cents:,
    sender_bank_account:,
    receiver_bank_account: bank_account
  )

  sender_bank_account.update(balance_in_cents: cached_sender_balance_in_cents)
  bank_account.update(balance_in_cents: cached_receiver_balance_in_cents)
end
