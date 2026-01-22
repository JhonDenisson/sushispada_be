Rails.application.routes.draw do
  namespace :auth do
    post "sign_up", to: "registrations#create"
    post "sign_in", to: "sessions#create"
    delete "sign_out", to: "sessions#destroy"
    get "me", to: "me#show"
  end

  namespace :customers do
    resources :categories, only: [ :index ]
    resources :products, only: [ :index, :show ]

    resources :addresses, only: [ :index, :show, :create, :update, :destroy ]

    resources :orders, only: [ :create, :show ] do
      resources :order_items, only: [ :create, :update, :destroy ]
      post :checkout, on: :member
    end
  end

  namespace :admin do
    resources :categories
    resources :products
    # resources :delivery_zones
    # resources :coupons
    resources :orders, only: [ :index, :update ]
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
