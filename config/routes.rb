Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root 'pages#home'
  get 'page/:id', to:'pages#home', as: :get_products_from_category
  # get 'products/:position', to:'products#show', as: :get_product
  get 'cart/', to:'carts#show', as: :get_cart

  get 'product/:id', to:'products#show', as: :get_product
  
  get 'order/', to:'orders#home', as: :home_order
  # post 'order/', to:'orders#new', as: :new_order

  post 'cart/:id', to:'carts#create', as: :add_product
  delete 'cart/:id', to:'carts#destroy', as: :destroy_cart_product
end
