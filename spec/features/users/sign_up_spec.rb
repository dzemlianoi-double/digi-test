# frozen_string_literal: true

RSpec.describe 'Sign up', type: :feature do
  let(:sign_up_page) { Users::SignUpPage.new }

  it 'check that all the attributes are available on the page' do
    sign_up_page.load

    expect(sign_up_page).to be_all_there
  end

  context 'when use is already logined' do
    let(:user) { create(:user) }
    let(:bank_account_page) { BankAccounts::ShowPage.new }

    before do
      login_as(user, scope: :user)
      sign_up_page.load
    end

    it 'redirects to the bank account page' do
      expect(bank_account_page).to be_displayed
      expect(bank_account_page).to be_all_there
      expect(bank_account_page.error_flash.text).to eq(I18n.t('devise.failure.already_authenticated'))
    end
  end

  context 'when use input invalid data' do
    context 'when user has already had an account' do
      let(:user) { create(:user) }
      let(:bank_account_page) { BankAccounts::ShowPage.new }

      before do
        sign_up_page.load
      end

      it 'redirects to the bank account page after passing the email and password of user' do
        sign_up_page.register_user(user)

        expect(sign_up_page).to be_all_there
        expect(sign_up_page.error_flash.text).to include('Email has already been taken')
      end
    end

    context 'when user has no account' do
      let(:user) { build(:user, email: nil, password: nil) }
      let(:bank_account_page) { BankAccounts::ShowPage.new }

      before do
        sign_up_page.load
      end

      it 'displays errors' do
        sign_up_page.register_user(user)

        expect(sign_up_page).to be_all_there
        expect(sign_up_page.error_flash.text).to include("Email can't be blank")
        expect(sign_up_page.error_flash.text).to include("Password can't be blank")
      end
    end
  end

  context 'when user enters correct data' do
    let(:user) { build(:user) }
    let(:bank_account_page) { BankAccounts::ShowPage.new }

    before do
      sign_up_page.load
    end

    it 'successfully register user' do
      sign_up_page.register_user(user)

      expect(bank_account_page).to be_displayed
      expect(bank_account_page).to be_all_there
      expect(bank_account_page.success_flash.text).to include(I18n.t('devise.registrations.signed_up'))
    end
  end
end
