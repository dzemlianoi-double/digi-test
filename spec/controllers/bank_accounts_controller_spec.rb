# frozen_string_literal: true

RSpec.describe BankAccountsController do
  let(:current_user) { create(:user) }

  describe '#show' do
    subject(:call_action) { get :show }

    it_behaves_like 'authorizable' do
      let(:subject) { call_action }
    end

    context 'instance_variable' do
      before do
        sign_in(current_user)
      end

      it 'sets presenter to variable' do
        show_presenter_stub = instance_double(BankAccounts::ShowPresenter)

        allow(BankAccounts::ShowPresenter).to receive(:new)
                                          .with(current_user:, params: instance_of(ActionController::Parameters))
          .and_return(show_presenter_stub)

        call_action

        expect(assigns(:presenter)).to eq(show_presenter_stub)
      end
    end
  end
end
