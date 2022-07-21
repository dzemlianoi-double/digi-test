# frozen_string_literal: true

class BankAccountDecorator < Draper::Decorator
  delegate_all

  def balance
    convert_from_cents_to_usd(balance_in_cents)
  end

  private

  def convert_from_cents_to_usd(money_in_cents)
    money_in_cents / 100.0
  end
end
