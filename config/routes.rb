Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'home#index'
  namespace :admin do
    resources :hotels
    resources :rooms
    resources :bookings
  end

  namespace :api do
    resources :hotels
    resources :rooms
    resources :bookings
  end
end
