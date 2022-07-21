# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_one :user_bank_account, dependent: :destroy

  after_create :create_user_bank_account!
end
