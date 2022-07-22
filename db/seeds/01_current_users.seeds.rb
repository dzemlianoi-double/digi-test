# frozen_string_literal: true

# Users to login

User.create_with(password: 'password').find_or_create_by(email: 'user@example.com')
User.create_with(password: 'password').find_or_create_by(email: 'user1@example.com')

# # frozen_string_literal: true

# require 'factory_bot_rails'

# # USERS_COUNT = 10
# TRANSACTIONS_COUNT = 20

# # Users
# # FactoryBot.create_list(:user, USERS_COUNT, password: 'password')

# # Update bank accounts
# # BankAccount.update_all(balance_in_cents: 1_000_000) unless BankAccount.where.not(balance_in_cents: 0).exists?

# # Random transactions
# users = User.where.not(id: user.id)
# bank_account = user.bank_account.reload

# TRANSACTIONS_COUNT.times do
#   # Received transaction

#   received_amount_in_cents = rand(1..10000)
#   sender_bank_account = users.sample.bank_account

#   cached_sender_balance_in_cents = sender_bank_account.balance_in_cents - received_amount_in_cents
#   cached_receiver_balance_in_cents = bank_account.balance_in_cents + received_amount_in_cents

#   FactoryBot.create(
#     :money_transaction,
#     amount_in_cents: received_amount_in_cents,
#     cached_sender_balance_in_cents: cached_sender_balance_in_cents,
#     cached_receiver_balance_in_cents: cached_receiver_balance_in_cents,
#     sender_bank_account: sender_bank_account,
#     receiver_bank_account: bank_account,
#   )

#   # Sent transaction
#   sent_amount_in_cents = rand(1..10000)
#   receiver_bank_account = users.sample.bank_account

#   cached_sender_balance_in_cents = bank_account.balance_in_cents - sent_amount_in_cents
#   cached_receiver_balance_in_cents = receiver_bank_account.balance_in_cents + sent_amount_in_cents

#   FactoryBot.create(
#     :money_transaction,
#     amount_in_cents: sent_amount_in_cents,
#     cached_sender_balance_in_cents: cached_sender_balance_in_cents,
#     cached_receiver_balance_in_cents: cached_receiver_balance_in_cents,
#     sender_bank_account: bank_account,
#     receiver_bank_account: receiver_bank_account,
#   )
# end
