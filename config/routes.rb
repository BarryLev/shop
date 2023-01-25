Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root 'pages#home'
  
  # get 'products/:position', to:'products#show', as: :get_product
  get 'cart/', to:'carts#show', as: :get_cart

  get 'product/:id', to:'products#show', as: :get_product
  
  post 'cart/:id', to:'carts#create', as: :add_product
  delete 'cart/:id', to:'carts#destroy', as: :destroy_cart_product
end
