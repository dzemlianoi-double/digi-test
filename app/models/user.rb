# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  email               :string           not null
#  encrypted_password  :string           not null
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_one :bank_account, dependent: :destroy

  has_many :sent_transactions, class_name: 'MoneyTransaction',
                               foreign_key: :sender_id,
                               inverse_of: :sender_bank_account,
                               dependent: :destroy

  has_many :received_transactions, class_name: 'MoneyTransaction',
                                   foreign_key: :receiver_id,
                                   inverse_of: :receiver_bank_account,
                                   dependent: :destroy

  after_create :create_bank_account!
end
