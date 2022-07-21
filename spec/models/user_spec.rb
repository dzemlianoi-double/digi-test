# frozen_string_literal: true

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
    it { is_expected.to have_one(:user_bank_account).dependent(:destroy) }
  end

  describe 'callbacks' do
    let(:user) { build(:user) }

    it 'creates default bank account after user create' do
      user.save

      expect(user.reload.user_bank_account).to be_present
    end
  end
end
