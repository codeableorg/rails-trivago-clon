Rails.application.routes.draw do
  get 'bookings/index'
  get 'bookings/show'
  get 'bookings/new'
  get 'bookings/edit'
  get 'rooms/index'
  get 'rooms/show'
  get 'rooms/new'
  get 'rooms/edit'
  get 'hotels/index'
  get 'hotels/show'
  get 'hotels/new'
  get 'hotels/edit'
  devise_for :users
  root to: 'home#index'
end
