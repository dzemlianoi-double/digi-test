# frozen_string_literal: true

RSpec.describe 'Sign in', type: :feature do
  let(:sign_in_page) { Users::SignInPage.new }

  it 'check that all the attributes are available on the page' do
    sign_in_page.load

    expect(sign_in_page).to be_all_there
  end

  context 'when use is already logined' do
    let(:user) { create(:user) }
    let(:bank_account_page) { BankAccounts::ShowPage.new }

    before do
      login_as(user, scope: :user)
      sign_in_page.load
    end

    it 'redirects to the bank account page' do
      expect(bank_account_page).to be_displayed
      expect(bank_account_page).to be_all_there
      expect(bank_account_page.error_flash.text).to eq(I18n.t('devise.failure.already_authenticated'))
    end
  end

  context 'when use is not logined already' do
    context 'when user has already had an account' do
      let(:user) { create(:user) }
      let(:bank_account_page) { BankAccounts::ShowPage.new }

      before do
        sign_in_page.load
      end

      it 'redirects to the bank account page after passing the email and password of user' do
        sign_in_page.login_user(user)

        expect(bank_account_page).to be_displayed
        expect(bank_account_page).to be_all_there
        expect(bank_account_page.success_flash.text).to eq(I18n.t('devise.sessions.signed_in'))
      end
    end

    context 'when user has no account' do
      let(:user) { create(:user) }
      let(:bank_account_page) { BankAccounts::ShowPage.new }

      before do
        sign_in_page.load
      end

      it 'displays errors' do
        sign_in_page.login_user(build(:user))

        expect(sign_in_page).to be_displayed
        expect(sign_in_page.error_flash.text).to eq(I18n.t('devise.failure.invalid', authentication_keys: 'Email'))
      end
    end
  end
end
