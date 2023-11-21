Rails.application.routes.draw do
  resources :catalogs, only: [:index, :show] do
    resource :category, only: [:show]
    resource :genre, only: [:show]
    resources :reviews, only: [:index, :show, :create] do
      collection do
        get "good"
        get "bad"
        get "neutral"
      end
    end
    get "suggestions" => "catalogs#suggestions", on: :collection
  end

  resources :genres, only: [:index, :show] do
    resources :catalogs, only: [:index] do
      get "suggestions" => "catalogs#suggestions", on: :collection
    end
  end

  resources :categories, only: [:index, :show] do
    resources :catalogs, only: [:index] do
      get "suggestions" => "catalogs#suggestions", on: :collection
    end
  end

  resources :reviews, only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check

  root "catalogs#index"
end
