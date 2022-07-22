# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for(:users, only: %i[sessions registrations])

  resource :bank_account, only: %i[show]
  resources :money_transactions, only: %i[create]

  root to: 'bank_accounts#show'
end
