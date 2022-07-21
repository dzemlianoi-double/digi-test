# frozen_string_literal: true

# Sent transaction

require 'factory_bot_rails'

SENT_TRANSACTIONS_COUNT = 20
current_user = User.find_by(email: 'user@example.com')
users = User.where.not(id: current_user.id)
bank_account = current_user.bank_account.reload

SENT_TRANSACTIONS_COUNT.times do
  sent_amount = rand(1..10_000)
  receiver_bank_account = users.sample.bank_account

  cached_sender_balance = bank_account.balance - sent_amount
  cached_receiver_balance = receiver_bank_account.balance + sent_amount

  FactoryBot.create(
    :money_transaction,
    amount: sent_amount,
    cached_sender_balance:,
    cached_receiver_balance:,
    sender_bank_account: bank_account,
    receiver_bank_account:
  )
end
