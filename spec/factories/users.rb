# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@gmail.com" }
    password { FFaker::Lorem.characters(rand(Devise.password_length)) }
  end
end
