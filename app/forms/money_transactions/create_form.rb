# frozen_string_literal: true

module MoneyTransactions
  class CreateForm < BaseForm
    attr_accessor :sender, :receiver, :email, :amount_in_cents

    validates :email, presence: true
    validates :email, format: { with: User::EMAIL_PATTERN }, allow_blank: true
    validates :amount_in_cents, presence: true
    validates :amount_in_cents, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
    validate :sender_has_enough_money

    private

    def sender_has_enough_money
      return if sender.bank_account.balance_in_cents - amount_in_cents.to_i >= 0

      errors.add(:amount_in_cents, I18n.t('forms.errors.money_transactions.create.amount_in_cents.not_enough'))
    end
  end
end
