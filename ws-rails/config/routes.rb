WsRails::Application.routes.draw do
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