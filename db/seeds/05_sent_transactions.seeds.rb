# frozen_string_literal: true

# Sent transaction

require 'factory_bot_rails'

SENT_TRANSACTIONS_COUNT = 20

current_user = User.find_by(email: 'user@example.com')
users = User.where.not(id: current_user.id)
bank_account = current_user.bank_account.reload

SENT_TRANSACTIONS_COUNT.times do
  sent_amount_in_cents = rand(1..100_000)
  receiver_bank_account = users.sample.bank_account

  cached_sender_balance_in_cents = bank_account.reload.balance_in_cents - sent_amount_in_cents
  cached_receiver_balance_in_cents = receiver_bank_account.reload.balance_in_cents + sent_amount_in_cents

  FactoryBot.create(
    :money_transaction,
    amount_in_cents: sent_amount_in_cents,
    cached_sender_balance_in_cents:,
    cached_receiver_balance_in_cents:,
    sender_bank_account: bank_account,
    receiver_bank_account:
  )

  bank_account.update(balance_in_cents: cached_sender_balance_in_cents)
  receiver_bank_account.update(balance_in_cents: cached_receiver_balance_in_cents)
end
