# frozen_string_literal: true

# == Schema Information
#
# Table name: money_transactions
#
#  id                               :bigint           not null, primary key
#  amount_in_cents                  :integer          not null
#  cached_receiver_balance_in_cents :integer          not null
#  cached_sender_balance_in_cents   :integer          not null
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  receiver_bank_account_id         :bigint           not null
#  sender_bank_account_id           :bigint           not null
#
# Indexes
#
#  index_money_transactions_on_receiver_bank_account_id  (receiver_bank_account_id)
#  index_money_transactions_on_sender_bank_account_id    (sender_bank_account_id)
#
# Foreign Keys
#
#  fk_rails_...  (receiver_bank_account_id => bank_accounts.id)
#  fk_rails_...  (sender_bank_account_id => bank_accounts.id)
#
class MoneyTransaction < ApplicationRecord
  belongs_to :sender_bank_account, class_name: 'BankAccount', inverse_of: :sent_transactions
  belongs_to :receiver_bank_account, class_name: 'BankAccount', inverse_of: :received_transactions
end
