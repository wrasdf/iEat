WsRails::Application.routes.draw do
  get 'groups/today' => 'groups#today'
  get 'success' => 'success#index'
  post 'group/:id/orders/confirm' => 'orders#confirm'

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
      get 'groups/active' => 'groups#active'
      post 'groups/create' => 'groups#create'

      resources :groups do
        resources :orders
      end
    end
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  devise_for :users
  resources :users
end