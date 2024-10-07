Rails.application.routes.draw do
  #get 'users/show'
  devise_for :users
  root to: 'prototypes#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :prototypes do
    resources :comments, only: [:create]
  end
  resources :users, only: [:show]
end
