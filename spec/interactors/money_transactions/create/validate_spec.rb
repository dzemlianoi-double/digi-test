# frozen_string_literal: true

RSpec.describe MoneyTransactions::Create::Validate do
  subject(:interactor) { described_class.call(current_user:, receiver:, model:, params:) }

  let(:current_user) { create(:user) }
  let(:receiver) { create(:user) }
  let(:model) { MoneyTransaction.new }

  context 'when valid params provided successfull' do
    let(:params) { { email: receiver.email, amount_in_cents: 1000 } }

    before do
      current_user.bank_account.update(balance_in_cents: 1000)
    end

    it 'returns with success' do
      expect(interactor).to be_success
    end

    it 'must have valid model in context' do
      expect(interactor.model.errors).to be_blank
    end
  end

  context 'when transaction failed' do
    let(:params) { { email: nil, amount_in_cents: 1000 } }

    it 'return with fail' do
      expect(interactor).to be_failure
    end

    it 'doesnt save model but sets it to context' do
      expect(interactor.model.errors).to be_present
    end

    it 'copies error from email to receiver_bank_account_id' do
      expect(interactor.model.errors[:receiver_bank_account_id]).to be_present
    end
  end
end
