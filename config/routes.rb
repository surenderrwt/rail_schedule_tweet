Rails.application.routes.draw do
  resources :tweets
  get 'admin/users' => 'admin#users'
  get 'admin/user/:id/edit' => 'admin#edit', as: :edit_user
  post 'admin/user/:id/edit' => 'admin#update', as: :update_user
  root 'page#index'
  devise_for :users
  resources :roles
  get 'oauth/request' =>	 'session#new'
  match '/oauth/callback' => 'session#create', via: [:get, :post]
  # get '/auth/:provider/callback', to: 'sessions#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
