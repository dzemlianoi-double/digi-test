# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for(:users, only: %w[sessions#new session#destroy])

  root to: redirect('users/sign_in')
end
