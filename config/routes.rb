Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :orders
  resource :carts, except: :show

  root 'products#index'

  get '/cart', to:'carts#show', as: :cart

  get 'products/:id', to:'products#index', as: :products_from_category
  get 'product/:id', to:'products#show', as: :product
end
