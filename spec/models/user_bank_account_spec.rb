# frozen_string_literal: true

RSpec.describe UserBankAccount do
  describe 'columns' do
    it { is_expected.to have_db_column(:balance).with_options(default: 0, null: false) }
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
  end
end
