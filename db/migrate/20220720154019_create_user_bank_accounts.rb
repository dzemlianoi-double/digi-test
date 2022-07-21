# frozen_string_literal: true

class CreateUserBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :user_bank_accounts do |t|
      t.bigint :balance, default: 0, null: false
      t.belongs_to :user, index: true, unique: true, null: false
      t.timestamps
    end
  end
end
