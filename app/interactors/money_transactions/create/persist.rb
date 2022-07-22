# frozen_string_literal: true

module MoneyTransactions
  module Create
    class Persist < BaseInteractor
      def call # rubocop:disable Metrics/AbcSize
        ActiveRecord::Base.transaction do
          context.model.assign_attributes(model_params)
          context.model.save!

          context.receiver.bank_account.update!(balance_in_cents: receiver_new_amount)
          context.current_user.bank_account.update!(balance_in_cents: sender_new_amount)
        end
      rescue ActiveRecord::RecordInvalid
        context.model.errors.add(:base, I18n.t('forms.errors.money_transactions.create.base.something_went_wrong'))
        context.fail!
      end

      private

      def model_params
        {
          amount_in_cents: context.params[:amount_in_cents],
          receiver_bank_account: context.receiver.bank_account,
          cached_sender_balance_in_cents: sender_new_amount,
          cached_receiver_balance_in_cents: receiver_new_amount
        }
      end

      def receiver_new_amount
        context.receiver.bank_account.balance_in_cents + context.params[:amount_in_cents].to_i
      end

      def sender_new_amount
        context.current_user.bank_account.balance_in_cents - context.params[:amount_in_cents].to_i
      end
    end
  end
end
