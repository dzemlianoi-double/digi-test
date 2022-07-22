# frozen_string_literal: true

RSpec.describe MoneyTransactionDecorator, type: :decorator do
  subject(:money_transaction) do
    create(:money_transaction,
           receiver_bank_account: receiver.bank_account,
           sender_bank_account: sender.bank_account,
           amount_in_cents: 1000).decorate
  end
  let(:receiver) { create(:user) }
  let(:sender) { create(:user) }

  describe '#operation_type' do
    it 'returns ↑ if current user is sender' do
      allow(money_transaction.h).to receive(:current_user) { sender }
      expect(money_transaction.operation_type).to eq('↑')
    end

    it 'returns ↓ if current user is receiver' do
      allow(money_transaction.h).to receive(:current_user) { receiver }
      expect(money_transaction.operation_type).to eq('↓')
    end
  end

  describe '#operation_type_class' do
    it 'returns red if current user is sender' do
      allow(money_transaction.h).to receive(:current_user) { sender }
      expect(money_transaction.operation_type_class).to eq('red')
    end

    it 'returns green if current user is receiver' do
      allow(money_transaction.h).to receive(:current_user) { receiver }
      expect(money_transaction.operation_type_class).to eq('green')
    end
  end

  describe '#operation_email' do
    it 'returns receiver email if current user is sender' do
      allow(money_transaction.h).to receive(:current_user) { sender }
      expect(money_transaction.operation_email).to eq(receiver.email)
    end

    it 'returns sender email if current user is receiver' do
      allow(money_transaction.h).to receive(:current_user) { receiver }
      expect(money_transaction.operation_email).to eq(sender.email)
    end
  end

  describe '#left_on_balance' do
    it 'returns sender balance in usd if current user is sender' do
      allow(money_transaction.h).to receive(:current_user) { sender }
      expect(money_transaction.left_on_balance).to eq(10.0)
    end

    it 'returns receiver balance in usd if current user is receiver' do
      allow(money_transaction.h).to receive(:current_user) { receiver }
      expect(money_transaction.left_on_balance).to eq(10.0)
    end
  end

  describe '#amount' do
    it 'returns + with a amount in usd if current user is receiver' do
      allow(money_transaction.h).to receive(:current_user) { sender }
      expect(money_transaction.amount).to eq('-10.0')
    end

    it 'returns + with a balance in usd if current user is receiver' do
      allow(money_transaction.h).to receive(:current_user) { receiver }
      expect(money_transaction.amount).to eq('+10.0')
    end
  end
end
