# frozen_string_literal: true

RSpec.describe MoneyTransactionsController do
  let(:current_user) { create(:user) }

  describe '#create' do
    subject(:call_action) { post :create, params: }
    let(:params) { { transaction: {} } }
    let(:organizer_mock) { double(MoneyTransactions::Create::Organizer) }

    # it_behaves_like 'authorizable' do
    #   let(:subject) { call_action }
    # end

    context 'when valid params provided' do
      let(:params) { { transaction: { email: create(:user), amount_in_cents: 1 } } }
      let(:organizer_mock) { double(MoneyTransactions::Create::Organizer, success?: true) }

      before do
        current_user.bank_account.update(balance_in_cents: 1000)
        allow(MoneyTransactions::Create::Organizer).to receive(:call)
          .with(
            current_user:,
            params: instance_of(ActionController::Parameters)
          ).and_return(organizer_mock)
        sign_in(current_user)
      end

      it 'redirects to bank account' do
        expect(call_action).to redirect_to(bank_account_path)
      end

      it 'adds flash notice' do
        expect(call_action.request.flash[:notice]).to eq(I18n.t('flashes.notice.money_sent'))
      end
    end

    context 'when valid params provided' do
      let(:params) { { transaction: { email: create(:user), amount_in_cents: 1 } } }
      let(:model) { MoneyTransaction.new }
      let(:organizer_mock) { double(MoneyTransactions::Create::Organizer, success?: false, model:) }

      before do
        current_user.bank_account.update(balance_in_cents: 1000)
        allow(MoneyTransactions::Create::Organizer).to receive(:call)
          .with(
            current_user:,
            params: instance_of(ActionController::Parameters)
          ).and_return(organizer_mock)
        sign_in(current_user)
      end

      it 'assigns expected instance to presenter' do
        show_presenter_stub = instance_double(BankAccounts::ShowPresenter)

        allow(BankAccounts::ShowPresenter).to receive(:new)
                                          .with(
                                            current_user:,
                                            params: instance_of(ActionController::Parameters),
                                            transaction_with_error: model
                                          )
          .and_return(show_presenter_stub)

        call_action

        expect(assigns(:presenter)).to eq(show_presenter_stub)
      end

      it 'renders correct response' do
        expect(call_action).to render_template('bank_accounts/show')
      end
    end
  end
end
