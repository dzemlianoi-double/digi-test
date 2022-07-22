# frozen_string_literal: true

module BankAccounts
  class ShowPage < SitePrism::Page
    set_url '/'

    element :error_flash, '.alert-danger'
    element :success_flash, '.alert-success'

    element :new_transaction_email, 'input[name="transaction[email]"]'
    element :receiver_field_error, '.error-receiver-spec'
    element :new_transaction_amount, 'input[name="transaction[amount_in_cents]"]'
    element :amount_field_error, '.error-amount-spec'
    element :submit_new_transaction_button, 'input[type="submit"]'

    elements :transaction_rows, '.transaction-line-spec'

    elements :pagination_buttons, '.page-link'

    element :balance, '.balance-spec'

    expected_elements :new_transaction_email, :new_transaction_amount, :submit_new_transaction_button

    def click_on_page(number)
      pagination_buttons.detect { |button| button.text == number.to_s }.click
    end

    def balance_value
      balance.text
    end
  end
end
