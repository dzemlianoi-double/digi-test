# frozen_string_literal: true

class MoneyTransactionDecorator < Draper::Decorator
  delegate_all

  def operation_type
    user_is_sender? ? '↑' : '↓'
  end

  def operation_type_class
    user_is_sender? ? 'red' : 'green'
  end

  def operation_email
    user_is_sender? ? receiver_bank_account.user.email : sender_bank_account.user.email
  end

  def left_on_balance
    in_cents = user_is_sender? ? cached_sender_balance_in_cents : cached_receiver_balance_in_cents
    convert_from_cents_to_usd(in_cents)
  end

  def amount
    sign = user_is_sender? ? '-' : '+'

    sign + convert_from_cents_to_usd(amount_in_cents).to_s
  end

  private

  def user_is_sender?
    sender_bank_account.user == h.current_user
  end

  def convert_from_cents_to_usd(money_in_cents)
    money_in_cents / 100.0
  end
end
