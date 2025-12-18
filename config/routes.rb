Rails.application.routes.draw do
  namespace :auth do
    post "sign_up", to: "registrations#create"
    post "sign_in", to: "sessions#create"
  end

  namespace :customers do
    resources :categories, only: [:index]
    resources :products, only: [:index, :show]
  end

  namespace :admin do
    resources :categories
    resources :products
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
