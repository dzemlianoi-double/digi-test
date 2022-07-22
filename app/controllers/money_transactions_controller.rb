# frozen_string_literal: true

class MoneyTransactionsController < ApplicationController
  before_action :authenticate_user!

  def create # rubocop:disable Metrics/MethodLength
    result = MoneyTransactions::Create::Organizer.call(current_user:, params: permitted_create_params)

    if result.success?
      redirect_to bank_account_path, notice: t('flashes.notice.money_sent')
    else
      @presenter = BankAccounts::ShowPresenter.new(
        params: permitted_create_params,
        current_user:,
        transaction_with_error: result.model
      )
      render 'bank_accounts/show'
    end
  end

  private

  def permitted_create_params
    params.require(:transaction).permit(:email, :amount_in_cents)
  end
end
