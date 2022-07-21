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
# # BankAccount.update_all(balance: 1_000_000) unless BankAccount.where.not(balance: 0).exists?

# # Random transactions
# users = User.where.not(id: user.id)
# bank_account = user.bank_account.reload

# TRANSACTIONS_COUNT.times do
#   # Received transaction

#   received_amount = rand(1..10000)
#   sender_bank_account = users.sample.bank_account

#   cached_sender_balance = sender_bank_account.balance - received_amount
#   cached_receiver_balance = bank_account.balance + received_amount

#   FactoryBot.create(
#     :money_transaction,
#     amount: received_amount,
#     cached_sender_balance: cached_sender_balance,
#     cached_receiver_balance: cached_receiver_balance,
#     sender_bank_account: sender_bank_account,
#     receiver_bank_account: bank_account,
#   )

#   # Sent transaction
#   sent_amount = rand(1..10000)
#   receiver_bank_account = users.sample.bank_account

#   cached_sender_balance = bank_account.balance - sent_amount
#   cached_receiver_balance = receiver_bank_account.balance + sent_amount

#   FactoryBot.create(
#     :money_transaction,
#     amount: sent_amount,
#     cached_sender_balance: cached_sender_balance,
#     cached_receiver_balance: cached_receiver_balance,
#     sender_bank_account: bank_account,
#     receiver_bank_account: receiver_bank_account,
#   )
# end
