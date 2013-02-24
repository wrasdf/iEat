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


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  devise_for :users
  resources :users
end