# frozen_string_literal: true

RSpec.describe MoneyTransactions::Create::FindReceiver do
  subject(:interactor) { described_class.call(params:, model:, current_user:) }

  let(:model) { MoneyTransaction.new }
  let(:current_user) { create(:user) }

  context 'when receiver found by email' do
    let(:user) { create(:user) }
    let(:params) { { email: user.email } }

    it 'sets the receiver to context' do
      expect(interactor.receiver).to eq(user)
    end

    it 'doesnt assign error to model' do
      expect(interactor.model.errors).to be_blank
    end

    it 'returns success status' do
      expect(interactor).to be_success
    end

    context 'when receiver couldnt be found by email' do
      let(:params) { { email: FFaker::Internet.email } }

      it 'sets the empty receiver to context' do
        expect(interactor.receiver).to be_nil
      end

      it 'assign error to model' do
        expect(interactor.model.errors[:receiver_bank_account_id]).to eq(
          [
            I18n.t('forms.errors.money_transactions.create.receiver_bank_account_id.email_doesnt_belong')
          ]
        )
      end

      it 'returns success status' do
        expect(interactor).to be_failure
      end
    end
  end
end
