# frozen_string_literal: true

module MoneyTransactions
  module Create
    class FindReceiver < BaseInteractor
      def call
        context.receiver = User.find_by(email: context.params[:email])

        return if context.receiver.present?

        context.model.errors.add(
          :receiver_bank_account_id,
          :invalid,
          message: I18n.t('forms.errors.money_transactions.create.receiver_bank_account_id.email_doesnt_belong')
        )

        context.fail!
      end
    end
  end
end
