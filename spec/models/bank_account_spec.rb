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
RSpec.describe BankAccount do
  describe 'columns' do
    it { is_expected.to have_db_column(:balance_in_cents).with_options(default: 0, null: false) }
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
  end
end
