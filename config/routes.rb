# frozen_string_literal: true

Rails.application.routes.draw do

  get 'comments/new'
  get 'comments/edit'
  get 'comments/create'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'
  get 'static_pages/home'
  get '/help', to: 'static_pages#help', as: 'helf'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end

  devise_for :users,
             controllers: {
               #  :omniauth_callbacks => "users/omniauth_callbacks",
               omniauth_callbacks: 'users/omniauth_callbacks',
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :microposts, only: %i[create destroy] do
    resource :emote do
      get :count_emoji
    end
  end
  resources :comments

  resources :relationships, only: %i[create destroy]
end
