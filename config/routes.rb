Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  post "/session", to: "sessions#authenticate"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [ :create ] do
        get "account", on: :member
        get "report", on: :member
      end

      resources :transactions, only: [] do
        post "borrow", on: :collection
        post "return", on: :collection
      end

      resources :books, only: [ :index ] do
        get "income", on: :member
      end
    end
  end
end
