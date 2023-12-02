# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },

  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :catalogs, only: %i[index show] do
    resource :category, only: [:show]
    resource :genre, only: [:show]
    resources :reviews, only: %i[index show create update destroy] do
      collection do
        get 'good'
        get 'bad'
        get 'neutral'
      end
    end
    get 'suggestions' => 'catalogs#suggestions', on: :collection
  end

  resources :genres, only: %i[index show] do
    resources :catalogs, only: [:index] do
      get 'suggestions' => 'catalogs#suggestions', on: :collection
    end
  end

  resources :categories, only: %i[index show] do
    resources :catalogs, only: [:index] do
      get 'suggestions' => 'catalogs#suggestions', on: :collection
    end
  end

  resources :reviews, only: [:show]

  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'catalogs#index'
end
