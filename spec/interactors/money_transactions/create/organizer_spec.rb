# frozen_string_literal: true

RSpec.describe MoneyTransactions::Create::Organizer do
  subject(:organizer) { described_class.call(current_user:, params:) }

  let(:current_user) { create(:user) }
  let(:expected_interactors) do
    [
      MoneyTransactions::Create::Initialize,
      MoneyTransactions::Create::Validate,
      MoneyTransactions::Create::FindReceiver,
      MoneyTransactions::Create::Persist
    ]
  end

  it 'has correct interactors' do
    expect(described_class.organized).to eq(expected_interactors)
  end

  context 'when correct params provided' do
    let(:receiver) { create(:user) }
    let(:params) { { email: receiver.email, amount_in_cents: 1 } }

    before do
      current_user.bank_account.update(balance_in_cents: 1000)
    end

    it 'return with success' do
      expect(organizer).to be_success
    end

    it 'saves model and sets it to context' do
      expect(organizer.model).to be_persisted
    end
  end

  context 'when invalid params provided' do
    context 'when validation failed' do
      let(:receiver) { create(:user) }
      let(:params) { { email: receiver.email, amount_in_cents: -3 } }

      it 'return with failure' do
        expect(organizer).to be_failure
      end

      it 'doesnt save model' do
        expect(organizer.model).to be_invalid
      end

      it "doesn't save money transaction" do
        expect { organizer }.not_to(change { MoneyTransaction.count })
      end

      it "doesn't change balance of sender" do
        expect { organizer }.not_to(change { current_user.bank_account.reload.balance_in_cents })
      end
    end

    context 'when receiver couldnt be found' do
      let(:params) { { email: FFaker::Internet.email, amount_in_cents: 1 } }

      before do
        current_user.bank_account.update(balance_in_cents: 1000)
      end

      it 'returns fail status' do
        expect(organizer).to be_failure
      end

      it 'doesnt save model' do
        expect(organizer.model).to be_invalid
      end

      it "doesn't save money transaction" do
        expect { organizer }.not_to(change { MoneyTransaction.count })
      end

      it "doesn't change balance of sender" do
        expect { organizer }.not_to(change { current_user.bank_account.reload.balance_in_cents })
      end
    end

    context 'when something went wrong during persist' do
      let(:receiver) { create(:user) }
      let(:params) { { email: receiver.email, amount_in_cents: 1 } }

      before do
        current_user.bank_account.update(balance_in_cents: 1000)
        allow(current_user.bank_account).to receive(:update!).and_raise(ActiveRecord::RecordInvalid)
      end

      it 'returns fail status' do
        expect(organizer).to be_failure
      end

      it 'assign error to model' do
        expect(organizer.model.errors).to be_present
      end

      it "doesn't save money transaction" do
        expect { organizer }.not_to(change { MoneyTransaction.count })
      end

      it "doesn't change balance of sender" do
        expect { organizer }.not_to(change { current_user.bank_account.reload.balance_in_cents })
      end
    end
  end
end
