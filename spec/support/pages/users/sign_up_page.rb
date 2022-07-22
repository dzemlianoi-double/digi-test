# frozen_string_literal: true

module Users
  class SignUpPage < SitePrism::Page
    set_url '/users/sign_up'

    element :error_flash, '.alert-danger'

    element :email_input, 'input[name="user[email]"]'
    element :password_input, 'input[name="user[password]"]'
    element :password_confirmation_input, 'input[name="user[password_confirmation]"]'
    element :sign_up_button, 'input[type="submit"]'

    expected_elements :email_input, :password_input, :sign_in_button

    def register_user(user)
      email_input.set(user.email)
      password_input.set(user.password)
      password_confirmation_input.set(user.password)
      sign_up_button.click
    end
  end
end
