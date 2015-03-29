Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  match '/help', to: 'home#help', via: 'get'
  match '/about', to: 'home#about', via: 'get'
  match '/user/:id', to: 'users#show', via: 'get', as: :show_user
  match '/user/:id/following', to: 'users#following', via: 'get', as: :following_user
  match '/user/:id/followers', to: 'users#followers', via: 'get', as: :followers_user
  match '/mycourse', to: 'home#mycourse', via: 'get'
  #match '*path' => redirect('/'), via: :get

  resources :relationships, only: [:create, :destroy]
  resources :microposts,          only: [:create, :destroy]

  devise_for :users, :controllers => { registrations: 'registrations', sessions: 'sessions' }
  devise_scope :user do
    get "register", :to => "registrations#new"
    get "login", :to => "sessions#new"
    get "logout", :to => "devise/sessions#destroy"
  end
end
