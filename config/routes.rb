Rails.application.routes.draw do

  root 'dashboard#home'

  resource :cart, only: [:show] 
  resources :orders 

  resources :products, only: [:index, :show] do 
    member do 
      post :add_to_cart
    end
  end

  resource :profile
  resources :offers, only: :create do 
    member do
      patch 'offer', as: 'vote'
    end
  end

  namespace :admin do
    root 'admin#root'
    resources :users, except: [:new, :create]
    resources :products, except: :show
    resources :offers, except: :show
  end

  get 'sign_up', to: 'users#new'
  post 'sign_up', to: 'users#create'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  delete 'sign_out', to: 'sessions#destroy'
  
end
