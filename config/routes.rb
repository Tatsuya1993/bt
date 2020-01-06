Rails.application.routes.draw do

  root   'static_pages#home'
  get    '/help',               to: 'static_pages#help'
  get    '/terms',              to: 'static_pages#terms'
  get    '/privacy',            to: 'static_pages#privacy'
  get    '/about',              to: 'static_pages#about'
  get    '/contact',            to: 'static_pages#contact'
  get    '/login',              to: 'sessions#new'
  post   '/login',              to: 'sessions#create'
  delete '/logout',             to: 'sessions#destroy'
  get    '/favorites/index'
  post   '/favorites/:topic_id', to: 'favorites#favorite', as: 'favorite'
  delete '/favorites/:topic_id', to: 'favorites#unfavorite', as: 'unfavorite'
  get    '/uploads/create'
  get    '/uploads/destroy'


  resources :users
  resources :topics do
    collection do
      post 'confirm'
    end
    
    member do
      patch 'edit_confirm'
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