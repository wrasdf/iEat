WsRails::Application.routes.draw do
  resources :orders

  get 'restaurants' => 'restaurants#list'
  resources :restaurants do
    resources :dishes
  end

  resources :groups do
    resources :orders
  end

  namespace :api do
    namespace :v1 do
      devise_for :users
      get 'restaurants' => 'restaurants#list'
      get 'groups/:id/dishes' => 'dishes#detail'
      get 'groups/active' => 'groups#active'
      get 'groups/:id' => 'groups#detail'
      post 'groups/create' => 'groups#create'
      post 'groups/:group_id/orders/create' => 'orders#create'
      resources :groups
    end
  end

  authenticated :user do
    root :to => 'login#index'
  end

  root :to => "login#index"

  devise_for :users
  resources :users
end