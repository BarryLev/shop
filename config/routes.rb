Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :orders, :products
  resource :carts
  resource :category, only: :show

  root 'products#index'
end
