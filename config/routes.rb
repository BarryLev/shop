Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root 'pages#home'
  
  get 'products/:position', to:'products#show', as: :get_product
  get 'carts/', to:'carts#index', as: :get_cart
  delete 'carts/:id', to:'carts#destroy', as: :destroy_cart_product

  post 'pages/:id', to:'pages#create', as: :create_cart_product
end
