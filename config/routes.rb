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
  namespace :admin do
    resources :categories
    resources :products
    resources :users
    resources :orders
    resources :suggest_products
    resources :csv, only: :create
    resources :charts, :line_chart
  end
end
