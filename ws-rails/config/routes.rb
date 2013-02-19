WsRails::Application.routes.draw do
  resources :restaurants do
    resources :dishes
  end

  match '/myorders' => 'order#my_orders'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end