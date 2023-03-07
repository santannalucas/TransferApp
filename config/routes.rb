Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :accounts, only: [:index, :show]
  resources :transfers, only: [:create]

  root 'accounts#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
