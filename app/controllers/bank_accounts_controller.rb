# frozen_string_literal: true

class BankAccountsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def show
    @bank_account = current_user.bank_account.decorate

    @pagy, transactions = pagy(@bank_account.transactions)
    @decorated_transactions = transactions.decorate

    @new_transaction = @bank_account.sent_transactions.new
  end
end
