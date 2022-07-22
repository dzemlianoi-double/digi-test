# frozen_string_literal: true

RSpec.describe MoneyTransactions::Create::Initialize do
  subject(:interactor) { described_class.call(current_user:) }

  let(:current_user) { create(:user) }

  it 'sets new sent transaction of current user to model' do
    expect(interactor.model.attributes).to eq(current_user.bank_account.sent_transactions.new.attributes)
  end
end
