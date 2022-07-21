# frozen_string_literal: true

# Update bank accounts

DEFAULT_BALANCE = 1_000_000

BankAccount.update_all(balance: DEFAULT_BALANCE) unless BankAccount.where.not(balance: 0).exists? # rubocop:disable Rails/SkipsModelValidations
