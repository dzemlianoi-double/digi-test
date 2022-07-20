# frozen_string_literal: true

class BankAccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    @bank_account = current_user.user_bank_account
  end
end
