# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :publishing_targets, only: %i[edit update]
  # resources :content_items, only: %i[index show new create edit update destroy]
  resources :content_items do
    collection do
      get :search
    end
  end
  resources :social_networks, only: %i[index new create]

  root to: 'content_items#index'
end
