# frozen_string_literal: true

module MoneyTransactions
  module Create
    class FindReceiver < BaseInteractor
      def call # rubocop:disable Metrics/AbcSize
        context.receiver = User.where.not(id: context.current_user.id).find_by(email: context.params[:email])

        return if context.receiver.present?

        assign_error_to_model

        context.fail!
      end

      private

      def assign_error_to_model
        context.model.errors.add(
          :receiver_bank_account_id,
          :invalid,
          message: I18n.t('forms.errors.money_transactions.create.receiver_bank_account_id.email_doesnt_belong')
        )
      end
    end
  end
end
