# frozen_string_literal: true

RSpec.describe 'Show page', type: :feature do
  let(:show_page) { BankAccounts::ShowPage.new }
  let(:user) { create(:user) }

  it 'check that all the attributes are available on the page' do
    login_as(user)
    show_page.load

    expect(show_page).to be_all_there
  end

  context 'when use is not logined' do
    let(:sign_in_page) { Users::SignInPage.new }

    before do
      show_page.load
    end

    it 'redirects to the bank account page' do
      expect(sign_in_page).to be_displayed
      expect(sign_in_page).to be_all_there
      expect(sign_in_page.error_flash.text).to eq(I18n.t('devise.failure.unauthenticated'))
    end
  end

  context 'when there is no transactions' do
    before do
      login_as(user)
      show_page.load
    end

    it 'displays default state with no transactions' do
      expect(show_page).not_to have_transaction_rows
      expect(show_page).to have_text(I18n.t('bank_account.empty_state'))
    end
  end

  context 'when transactions exists' do
    before do
      create_list(:money_transaction, 11, sender_bank_account: user.bank_account)
      login_as(user)
      show_page.load
    end

    it 'displays default state with no transactions' do
      expect(show_page).not_to have_text(I18n.t('bank_account.empty_state'))
      expect(show_page.transaction_rows.count).to eq(10)
      show_page.click_on_page(2)
      sleep(1) # :(
      expect(show_page.transaction_rows.count).to eq(1)
    end
  end

  context 'when transactions exists' do
    before do
      create_list(:money_transaction, 11, sender_bank_account: user.bank_account)
      login_as(user)
      show_page.load
    end

    it 'displays transactions' do
      expect(show_page).not_to have_text(I18n.t('bank_account.empty_state'))
      expect(show_page.transaction_rows.count).to eq(10)
      show_page.click_on_page(2)
      sleep(1) # :(
      expect(show_page.transaction_rows.count).to eq(1)
    end
  end

  context 'when sends new transaction form' do
    let(:receiver) { create(:user) }

    before do
      user.bank_account.update(balance_in_cents: 1000)
      login_as(user)
      show_page.load
    end

    it 'performs the money transaction if input data is valid' do
      show_page.new_transaction_email.set(receiver.email)
      show_page.new_transaction_amount.set(1)
      show_page.submit_new_transaction_button.click

      expect(show_page).to be_all_there
      expect(show_page.transaction_rows.count).to eq(1)
      expect(show_page.balance_value).to eq('9.99')
      expect(show_page.success_flash.text).to eq(I18n.t('flashes.notice.money_sent'))
    end

    it 'doesnt perform the transactio if input data is invalid' do
      show_page.new_transaction_email.set(nil)
      show_page.new_transaction_amount.set(nil)
      show_page.submit_new_transaction_button.click

      expect(show_page).to be_all_there
      expect(show_page.transaction_rows.count).to eq(0)
      expect(show_page.balance_value).to eq('10.0')
      expect(show_page.amount_field_error.text).to eq("can't be blank")
      expect(show_page.receiver_field_error.text).to eq("can't be blank")
    end
  end
end
