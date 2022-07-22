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
FactoryBot.define do
  factory :bank_account do
    balance_in_cents { 1_000_000 }

    association :user
  end
end
