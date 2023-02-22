Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :orders, :products, :categories
  resource :cart, only: [:show] do
    member do
      patch 'add_product', as: :add_product
      patch 'delete_product', as: :destroy_product
    end
  end

  root 'products#index'
end
