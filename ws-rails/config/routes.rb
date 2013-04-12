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
      get 'groups/:id/due_date' => 'groups#due_date'
      post 'groups/create' => 'groups#create'
      post 'groups/:group_id/orders/create' => 'orders#create'
      get 'mybills' => 'orders#list'
      get 'mybills/paid/:id' => 'orders#paid'
      get 'orders/delete/:id' => 'orders#delete'
      resources :groups
    end
  end

  authenticated :user do
    root :to => redirect("/groups")
  end

  root :to => redirect("/users/sign_in")

  devise_for :users

end