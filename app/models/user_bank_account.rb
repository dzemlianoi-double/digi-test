# frozen_string_literal: true

class UserBankAccount < ApplicationRecord
  belongs_to :user
end
