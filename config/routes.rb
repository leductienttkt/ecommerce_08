Rails.application.routes.draw do
  root "static_pages#home"
  post "/signin", to: "sessions#create"
  delete "/signout", to: "sessions#destroy"
end
