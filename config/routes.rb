Rails.application.routes.draw do
  root "static_pages#index"
  post "/signin", to: "sessions#create"
  delete "/signout", to: "sessions#destroy"
  resources :users
  resources :cart_items
  resources :products
  resources :ratings
  resources :suggest_products
  resources :carts
  resources :comments
  resources :orders
end
