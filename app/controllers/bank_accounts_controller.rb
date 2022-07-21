# frozen_string_literal: true

class BankAccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    @presenter = BankAccounts::ShowPresenter.new(current_user:, params: permitted_show_params)
  end

  private

  def permitted_show_params
    params.permit(:page)
  end
end
