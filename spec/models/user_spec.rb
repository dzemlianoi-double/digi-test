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
end
