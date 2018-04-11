Rails.application.routes.draw do
  get 'items/create'

  resources :lists do
    resources :items
  end
  root 'lists#index'
end
