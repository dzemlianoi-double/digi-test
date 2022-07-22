# frozen_string_literal: true

class CreateMoneyTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :money_transactions do |t|
      t.belongs_to :sender_bank_account, class_name: 'BankAccount', null: false, index: true,
                                         foreign_key: { to_table: :bank_accounts }
      t.belongs_to :receiver_bank_account, class_name: 'BankAccount', null: false, index: true,
                                           foreign_key: { to_table: :bank_accounts }
      t.integer :amount_in_cents, null: false
      t.integer :cached_sender_balance_in_cents, null: false
      t.integer :cached_receiver_balance_in_cents, null: false

      t.timestamps
    end
  end
end
