# frozen_string_literal: true

class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_accounts do |t|
      t.bigint :balance_in_cents, default: 0, null: false
      t.belongs_to :user, index: true, unique: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
