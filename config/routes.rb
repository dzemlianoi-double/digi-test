# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: redirect('users/sign_in')
end
