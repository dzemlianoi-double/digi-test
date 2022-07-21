# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  email               :string           not null
#  encrypted_password  :string           not null
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
RSpec.describe User do
  describe 'columns' do
    it { is_expected.to have_db_column(:email) }
    it { is_expected.to have_db_column(:encrypted_password) }
    it { is_expected.to have_db_column(:remember_created_at) }
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(:email).unique }
  end

  describe 'relations' do
    it { is_expected.to have_one(:bank_account).dependent(:destroy) }
  end

  describe 'callbacks' do
    let(:user) { build(:user) }

    it 'creates default bank account after user create' do
      user.save

      expect(user.reload.bank_account).to be_present
    end
  end
end
