# frozen_string_literal: true

module BankAccounts
  class ShowPresenter
    include Pagy::Backend

    attr_reader :paginator

    def initialize(params:, current_user:, transaction_with_error: nil)
      @params = params
      @current_user = current_user
      @transaction_with_error = transaction_with_error
    end

    def bank_account
      @bank_account ||= current_user.bank_account.decorate
    end

    def transactions
      @transactions ||= paginated_collection.decorate
    end

    def new_transaction
      @new_transaction ||= transaction_with_error || bank_account.sent_transactions.new
    end

    private

    attr_reader :current_user, :params, :transaction_with_error

    def raw_transactions
      @raw_transactions ||= bank_account.transactions.order(created_at: :desc)
    end

    def paginated_collection
      return @paginated_collection if @paginated_collection

      @paginator, @paginated_collection = pagy(raw_transactions)

      @paginated_collection
    end
  end
end
