class Admin::HomeController < ApplicationController
  before_action :authorization_method

  def index
    @popularhotels = Hotel.joins(rooms: :bookings)
    .group('id')
    .order('count(bookings.id) DESC')
    
    @lesspopularhotels = Hotel.joins(rooms: :bookings)
    .group('id')
    .order('count(bookings.id) ASC')
  end

  def authorization_method
    authorize [:admin, :home]
  end
end
