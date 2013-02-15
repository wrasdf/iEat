WsRails::Application.routes.draw do
  resources :restaurants do
    resources :dishes
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end