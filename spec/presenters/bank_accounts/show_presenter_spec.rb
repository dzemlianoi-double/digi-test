# frozen_string_literal: true

RSpec.describe BankAccounts::ShowPresenter do
  subject(:presenter) do
    described_class.new(current_user:, params:, transaction_with_error: transaction)
  end

  let(:current_user) { create(:user) }
  let(:params) { {} }
  let(:transaction) { nil }

  describe '#bank_account' do
    it 'returns decorated account' do
      expect(presenter.bank_account).to be_a(BankAccountDecorator)
    end

    it 'returns bank account that belong to current user' do
      expect(presenter.bank_account.id).to eq(current_user.bank_account.id)
    end
  end

  describe '#transactions' do
    let!(:transactions) { create_list(:money_transaction, 3, sender_bank_account: current_user.bank_account) }

    it 'returns decorated collection' do
      expect(presenter.transactions).to match_array(
        [
          instance_of(MoneyTransactionDecorator),
          instance_of(MoneyTransactionDecorator),
          instance_of(MoneyTransactionDecorator)
        ]
      )
    end

    it 'returns paginated_collection' do
      stub_const('Pagy::DEFAULT', Pagy::DEFAULT.merge(items: 2))

      expect(presenter.transactions.count).to eq(2)
    end
  end

  describe '#new_transaction' do
    it 'returns brand new instance of current user sent transaction if not transaction with error provided' do
      expect(presenter.new_transaction.attributes).to eq(current_user.bank_account.sent_transactions.new.attributes)
    end

    context 'when transaction with error provided' do
      let(:transaction) { create(:money_transaction) }

      it 'returns provided transaction' do
        expect(presenter.new_transaction).to eq(transaction)
      end
    end
  end
end
