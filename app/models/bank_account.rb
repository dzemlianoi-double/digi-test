# frozen_string_literal: true

# == Schema Information
#
# Table name: bank_accounts
#
#  id               :bigint           not null, primary key
#  balance_in_cents :bigint           default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_bank_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class BankAccount < ApplicationRecord
  belongs_to :user

  has_many :sent_transactions, class_name: 'MoneyTransaction',
                               foreign_key: :sender_bank_account_id,
                               inverse_of: :sender_bank_account,
                               dependent: :destroy
  has_many :received_transactions, class_name: 'MoneyTransaction',
                                   foreign_key: :receiver_bank_account_id,
                                   inverse_of: :receiver_bank_account,
                                   dependent: :destroy

  def transactions
    sent_transactions.or(received_transactions)
  end
end
