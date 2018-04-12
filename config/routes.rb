Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  
  resources :users, only: :create

  resources :lists do
    resources :items
  end
  root 'welcome#index'
end
