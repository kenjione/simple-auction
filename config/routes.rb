# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: 'dashboard#index'

  resources :products do
    member do
      post :toggle_state
      post :accept_offer
      get :destroy_confirm
    end

    resources :bids, only: [:new, :create]
  end

  resources :bids, only: :create do
    post :approve, on: :member
  end
end
