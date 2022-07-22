# frozen_string_literal: true

module MoneyTransactions
  module Create
    class Validate < BaseInteractor
      def call # rubocop:disable Metrics/AbcSize
        return if form.valid?

        context.model.errors.copy!(form.errors)
        form.errors.where(:email).each { |error| context.model.errors.add(:receiver_bank_account_id, error.type) }

        context.fail!
      end

      private

      def form
        @form ||= ::MoneyTransactions::CreateForm.new(form_params)
      end

      def form_params
        context.params.merge(sender: context.current_user, receiver: context.receiver)
      end
    end
  end
end
