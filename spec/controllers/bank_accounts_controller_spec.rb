# frozen_string_literal: true

RSpec.describe BankAccountsController do
  describe '#show' do
    subject(:call_action) { get :show }

    it_behaves_like 'authorizable' do
      let(:subject) { call_action }
    end
  end
end
