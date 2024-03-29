Rails.application.routes.draw do
  get 'upvote/create'
  get 'upvote/destroy'
  resources :books
  resources :comments
  devise_for :users, path: '', path_names: { sign_up: 'register', sign_in: 'login', sign_out: 'logout'}

  devise_scope :user do
    get '/logout' => 'devise/sessions#destroy'
  end

  resources :conversations do
  	resources :messages
  end

  match 'users/:id' => 'users#show', via: :get, as: 'users'
  match 'users/:id/edit' => 'users#edit', via: :get, as: 'edit_user'
  match 'users/:id' => 'users#update', via: :put 
  get 'posts' => 'posts#index'

  match 'friends/new' => 'friends#create', via: :get
  match 'friends/new' => 'friends#create', via: :post, as: 'send_request'
  match 'friends/accept' => 'friends#accept', via: :post 
  match 'friends/reject' => 'friends#reject', via: :post 
  match 'friends/remove' => 'friends#remove', via: :post
  # match 'friends/:id/accept' => 'friends#accept', via: :post 
  # match 'friends/:id/reject' => 'friends#reject', via: :post 
  # match 'friends/:id/remove' => 'friends#remove', via: :post

  resources :users
  resources :friends, only: [:index]
  resources :posts, except: :index do
    resources :comments
  end

  resources :posts do
    resources :upvotes, only: [:create, :destroy]
  end

  resources :books, except: :index do
    resources :posts
  end

  resources :comments do
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "books#index"
end
