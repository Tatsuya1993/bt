Rails.application.routes.draw do

  get    'uploads/create'
  get    'uploads/destroy'
  root   'static_pages#home'
  get    '/help',               to: 'static_pages#help'
  get    '/about',              to: 'static_pages#about'
  get    '/contact',            to: 'static_pages#contact'
  get    '/login',              to: 'sessions#new'
  post   '/login',              to: 'sessions#create'
  delete '/logout',             to: 'sessions#destroy'
  get    '/favorites/index'
  post   '/favorites/:topic_id', to: 'favorites#favorite', as: 'favorite'
  delete '/favorites/:topic_id', to: 'favorites#unfavorite', as: 'unfavorite'


  resources :users
  resources :topics do
    collection do
      post 'confirm'
    end
    
    resources :comments
  end
  resources :words do
    collection do
      post 'confirm'
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :uploads,             only: [:create, :destroy]
end