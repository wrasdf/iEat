WsRails::Application.routes.draw do
  get 'groups/today' => 'groups#today'
  get 'groups/edit' => 'groups#edit'
  get 'success' => 'success#index'
  get 'create' => 'create#index'

  resources :groups
  resources :orders
  resources :restaurants do
    resources :dishes
  end

  get 'order' => 'api#my_order'
  get 'groupOrders' => 'api#group_orders'
  get 'activeGroups' => 'api#active_groups'

  namespace :api do
    namespace :v1 do
      devise_for :users
      get 'group/active' => 'groups#active'
    end
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  devise_for :users
  resources :users
end