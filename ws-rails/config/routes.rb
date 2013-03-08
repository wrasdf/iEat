WsRails::Application.routes.draw do
  get 'groups/today' => 'groups#today'
  post 'group/:id/orders/confirm' => 'orders#confirm'
  get 'restaurants/list' => 'restaurants#list'

  resources :orders

  resources :restaurants do
    resources :dishes
  end

  resources :groups do
    resources :orders
  end

  get 'groupOrders' => 'api#group_orders'
  get 'activeGroups' => 'api#active_groups'

  namespace :api do
    namespace :v1 do
      devise_for :users
      get 'restaurants' => 'restaurants#list'
      get 'groups/active' => 'groups#active'
      post 'groups/create' => 'groups#create'
      post 'groups/:id/orders/create' => 'orders#create'

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