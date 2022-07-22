# frozen_string_literal: true

module Users
  class SignInPage < SitePrism::Page
    set_url '/users/sign_in'

    element :error_flash, '.alert-danger'
    element :success_flash, '.alert-success'

    element :email_input, 'input[name="user[email]"]'
    element :password_input, 'input[name="user[password]"]'
    element :remember_me_checkbox, 'input[name="user[remember_me]"]'
    element :sign_in_button, 'input[type="submit"]'

    expected_elements :email_input, :password_input, :remember_me_checkbox, :sign_in_button

    def login_user(user)
      email_input.set(user.email)
      password_input.set(user.password)
      sign_in_button.click
    end
  end
end
