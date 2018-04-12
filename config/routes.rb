Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :users, only: [:new, :create]

  resources :lists do
    resources :items
  end
  root 'lists#index'
end
