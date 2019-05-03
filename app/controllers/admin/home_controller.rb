class Admin::HomeController < ApplicationController
  def index
    @popularhotels = Hotel.joins(rooms: :bookings)
    .group('id')
    .order('count(bookings.id) DESC')
    
    @lesspopularhotels = Hotel.joins(rooms: :bookings)
    .group('id')
    .order('count(bookings.id) ASC')
  end
end
