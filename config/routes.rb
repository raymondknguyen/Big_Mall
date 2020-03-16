# frozen_string_literal: true

Rails.application.routes.draw do
  resources :welcome, path: "/", only: [:index]
  # get '/', to: 'welcome#index'
  
  get '/register', to: 'users#new'

  resources :users, only: [:create]
  # post '/users', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  # resources :merchants, except: [:destroy]
  get "/merchants", to: 'merchants#index'
  post "/merchants", to: 'merchants#create'
  get "/merchants/new", to: 'merchants#new'
  get "/merchants/:id/edit", to: 'merchants#edit'
  get "/merchants/:id", to: 'merchants#show'
  patch "/merchants/:id", to: 'merchants#update'

  scope :merchants, module: nil do
    get ":merchant_id/items", to: 'merchant_items#index'
  end
  # get '/merchants/:merchant_id/items', to: 'merchant_items#index'

  post "/items/:item_id/reviews", to: 'reviews#create', as: :item_reviews
  get "/items/:item_id/reviews/new", to: 'reviews#new', as: :new_item_reviews
  get "/items", to: 'items#index'
  get "/items/:id", to: 'items#show', as: :item

  # resources :items, only: %i[index show] do
  #   resources :reviews, only: %i[new create]
  # end

  
  scope :profile, module: :profile, as: :profile do
    get '/', to: 'users#show'
    get '/edit', to: 'users#edit'
    patch '/user', to: 'users#update'
    get '/edit/pw', to: 'security#edit'
    patch '/user/pw', to: 'security#update'
    resources :orders, only: [:update]
    post '/orders', to: 'orders#create'
    get '/orders/new', to: 'orders#new', as: "new_profile_order"
    get '/orders', to: 'orders#index'
    get '/orders/:id', to: 'orders#show'
  end

  # namespace :profile do
  #   get '/', to: 'users#show'
  #   get '/edit', to: 'users#edit'
  #   patch '/user', to: 'users#update'
  #   get '/edit/pw', to: 'security#edit'
  #   patch '/user/pw', to: 'security#update'
  #   resources :orders, only: [:index, :show, :new, :create, :update]
  # end

  scope :admin, module: :admin, as: :admin do
    get '/', to: 'dashboard#index'
    get '/users/:id/orders', to: 'user_orders#index'
    get '/users/:id/orders/:id', to: 'user_orders#show'
    patch '/users/:id/orders/:id', to: 'user_orders#update'
    get '/merchants/:id/orders/:id', to: 'merchant_orders#show'
    get '/users', to: "users#index", as: :users
    get '/users/:id', to: "users#show", as: :user
    patch "/orders/:id", to: "orders#update", as: :order
    get '/merchants', to: "merchants#index"
    get '/merchants/:id', to: "merchants#show", as: :merchant
    patch '/merchants/:id', to: "merchants#update"
  end
  # namespace :admin do
  #   get '/', to: 'dashboard#index'
  #   get '/users/:id/orders', to: 'user_orders#index'
  #   get '/users/:id/orders/:id', to: 'user_orders#show'
  #   patch '/users/:id/orders/:id', to: 'user_orders#update'
  #   get '/merchants/:id/orders/:id', to: 'merchant_orders#show'
  #   resources :users, only: %i[index show]
  #   resources :orders, only: [:update]
  #   resources :merchants, only: %i[index show update]
  # end

  get "/merchant", to: "merchant/dashboard#index"
  get '/merchant/:merchant_id/items/new', to: "merchant/items#new"
  post '/merchant/:merchant_id/items', to: "merchant/items#create"
  patch '/merchant/items/:id/toggle', to: "merchant/toggle#update"
  get '/merchant/:merchant_id/discounts/new', to: "merchant/discounts#new"
  post '/merchant/:merchant_id/discounts', to: "merchant/discounts#create"
  get '/merchant/items', to: "merchant/items#index", as: :merchant_items
  get '/merchant/items/:id/edit', to: "merchant/items#edit", as: :edit_merchant_item
  get '/merchant/items/:id', to: "merchant/items#show", as: :merchant_item
  patch '/merchant/items/:id', to: "merchant/items#update"
  delete '/merchant/items/:id', to: "merchant/items#destroy"

  get '/merchant/orders/:id', to: "merchant/orders#show", as: :merchant_order
  patch '/merchant/item_orders/:id', to: "merchant/item_orders#update", as: :merchant_item_order

  get '/merchant/discounts', to: "merchant/discounts#index"
  get '/merchant/discounts/:id/edit', to: "merchant/discounts#edit"
  patch '/merchant/discounts/:id', to: "merchant/discounts#update"
  delete '/merchant/discounts/:id', to: "merchant/discounts#destroy"

  # namespace :merchant do
  #   get '/', to: 'dashboard#index'
  #   get '/:merchant_id/items/new', to: 'items#new'
  #   post '/:merchant_id/items', to: 'items#create'
  #   patch '/items/:id/toggle', to: 'toggle#update'
  #   get '/:merchant_id/discounts/new', to: 'discounts#new'
  #   post '/:merchant_id/discounts', to: 'discounts#create'
  #   resources :items, only: %i[index show edit update destroy]
  #   resources :orders, only: [:show]
  #   resources :item_orders, only: [:update]
  #   resources :discounts, only: %i[index edit update destroy]
  # end

  get "/reviews/:id/edit", to: 'reviews#edit'
  patch "/reviews/:id", to: 'reviews#update'
  delete "/reviews/:id", to: 'reviews#destroy'

  # resources :reviews, only: [:edit, :update, :destroy]

 scope :cart, module: nil do
    post '/:item_id', to: 'cart#add_item'
    get '/', to: 'cart#show'
    delete '/', to: 'cart#empty'
    delete '/:item_id', to: 'cart#remove_item'
    patch '/:item_id', to: 'cart#edit'
  end

  # post '/cart/:item_id', to: 'cart#add_item'
  # get '/cart', to: 'cart#show'
  # delete '/cart', to: 'cart#empty'
  # delete '/cart/:item_id', to: 'cart#remove_item'
  # patch '/cart/:item_id', to: 'cart#edit'

  get '/orders/new', to: 'orders#new'
  post '/orders', to: 'orders#create'
  get '/orders/:id', to: 'orders#show'
  # resources :orders, only: [:new, :create, :show]
end
