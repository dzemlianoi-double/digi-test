# frozen_string_literal: true

RSpec.describe MoneyTransactions::Create::Persist do
  subject(:interactor) { described_class.call(current_user:, params:, receiver:, model:) }

  let(:current_user) { create(:user) }
  let(:receiver) { create(:user) }
  let(:model) do
    build(
      :money_transaction,
      receiver_bank_account: receiver.bank_account,
      sender_bank_account: current_user.bank_account
    )
  end
  let(:params) { { amount_in_cents: 1 } }

  before do
    current_user.bank_account.update(balance_in_cents: 1000)
  end

  context 'when transaction successfull' do
    it 'return with success' do
      expect(interactor).to be_success
    end

    it 'saves model and sets it to context' do
      expect(interactor.model).to be_persisted
    end

    it 'saves money transaction' do
      expect { interactor }.to(change { current_user.bank_account.reload.sent_transactions.count }.from(0).to(1))
    end

    it 'changes balance of sender' do
      expect { interactor }.to(change { current_user.bank_account.reload.balance_in_cents }.from(1000).to(999))
    end

    it 'changes balance of receiver' do
      expect { interactor }.to(change { receiver.bank_account.reload.balance_in_cents }.from(0).to(1))
    end
  end

  context 'when transaction failed' do
    before do
      allow(model).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)
    end

    it 'return with fail' do
      expect(interactor).to be_failure
    end

    it 'doesnt save model but sets it to context' do
      expect(interactor.model.errors).to be_present
    end

    it 'doesnt save money transaction' do
      expect { interactor }.not_to(change { current_user.bank_account.reload.sent_transactions.count })
    end

    it 'doesnt change balance of sender' do
      expect { interactor }.not_to(change { current_user.bank_account.reload.balance_in_cents })
    end

    it 'doesnt balance of receiver' do
      expect { interactor }.not_to(change { receiver.bank_account.reload.balance_in_cents })
    end
  end
end
