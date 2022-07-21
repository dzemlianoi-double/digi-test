# frozen_string_literal: true

RSpec.describe MoneyTransactionDecorator, type: :decorator do
  subject(:bank_account) { create(:bank_account, balance_in_cents: 1000).decorate }

  describe '#balance' do
    it 'returns balance in usd' do
      expect(bank_account.balance).to eq(10.00)
    end
  end
end
