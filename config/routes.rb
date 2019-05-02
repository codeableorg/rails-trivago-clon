Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'home#index'
  namespace :admin do
    root 'home#index'
    resources :hotels
    resources :rooms
    resources :bookings
  end
  namespace :api do
    post "/login", to: 'sessions#create' 
    resources :hotels
    resources :rooms
    resources :bookings
  end
  
  resources :hotels do
    member do
      get 'rooms'
    end    
  end

  resources :rooms  do
    member do
      post 'book'
    end
  end

  resources :bookings
end
