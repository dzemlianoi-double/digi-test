# frozen_string_literal: true

module MoneyTransactions
  module Create
    class Initialize < BaseInteractor
      def call
        context.model = context.current_user.bank_account.sent_transactions.new
      end
    end
  end
end
