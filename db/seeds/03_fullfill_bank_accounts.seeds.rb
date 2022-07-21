# frozen_string_literal: true

# Update bank accounts

DEFAULT_BALANCE = 1_000_000

unless BankAccount.where.not(balance_in_cents: 0).exists?
  BankAccount.update_all(balance_in_cents: DEFAULT_BALANCE) # rubocop:disable Rails/SkipsModelValidations
end
