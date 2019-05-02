Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'home#index'
  namespace :admin do
    root 'home#index'
    resources :hotels do
      resources :promotions, controller: 'promotions_hotels'
    end
    resources :rooms do
      resources :promotions, controller: 'promotions_rooms'
    end
    resources :bookings
  end
  namespace :api do
    post "/login", to: 'sessions#create' 
    resources :hotels
    resources :rooms
    resources :bookings
  end
  namespace :regular do
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
