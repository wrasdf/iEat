WsRails::Application.routes.draw do
  resources :orders

  get 'mybills' => 'my_bills#index'

  resources :restaurants do
    resources :dishes
  end

  resources :groups do
    resources :orders
  end

  namespace :api do
    namespace :v1 do
      post "users", :to => "registrations#create"
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
    root :to => redirect("/users/sign_in")
  end

  root :to => redirect("/users/sign_in")

  devise_for :users

end