require 'rails_helper'

module Api
  RSpec.describe HotelsController, type: :controller do
    before(:each) do
      p "Cleaning DB"
      Booking.delete_all
      Room.delete_all
      Hotel.delete_all
      User.delete_all
     # Session.delete_all # required?
      p "Seeding for test"
      p "Adding users: 1..3"
      @user1 = User.create(name: "User1Admin", email: "cayala.w+testadmin@gmail.com", password: "123456", role: "admin", token: Devise.friendly_token[0, 30]) # admin
      @user2 = User.create(name: "User2Regular", email: "cayala.w+testuser1@gmail.com", password: "123456", token: Devise.friendly_token[0, 30]) # user      
      @user3 = User.create(name: "User3Regular", email: "cayala.w+testuser2@gmail.com", password: "123456", token: Devise.friendly_token[0, 30])

      p "Adding hotels 1..2"
      @hotel1 = Hotel.create(name: "TestHotel1", email: "cayala.w+testhotel1@gmail.com", city: "City Z", country: "CountryZ", address: "Address for hotel TestHotel1")
      @hotel2 = Hotel.create(name: "TestHotel2", email: "cayala.w+testhotel2@gmail.com", city: "City B", country: "CountryB", address: "Address for hotel TestHotel2")

      p "Adding rooms 1..4"
      @room1 = @hotel1.rooms.create(name: "Room1Hotel1", amount_of_beds: 2, price: 100)
      @room2 = @hotel1.rooms.create(name: "Room2Hotel1", amount_of_beds: 3, price: 200)
      @room3 = @hotel2.rooms.create(name: "Room1Hotel2", amount_of_beds: 2, price: 80)
      @room4 = @hotel2.rooms.create(name: "Room2Hotel2", amount_of_beds: 3, price: 120)

      p "Adding booking 1..2"
      @book1 = @user2.bookings.create!(start_date: Date.today + 1, end_date: Date.today + 3, paid_price: @room1.price, room_id: @room1.id)
      @book2 = @user3.bookings.create!(start_date: Date.today + 2, end_date: Date.today + 5, paid_price: @room2.price, room_id: @room2.id)

      p "Adding promos 1..2"
      @promo1 = @hotel1.promotions.create(start_date: Date.today + 15, end_date: Date.today + 30, discount_type: "Percentage", discount_amount: 5)
      @promo2 = @room2.promotions.create(start_date: Date.today + 25, end_date: Date.today + 45, discount_type: "Fixed", discount_amount: 10)
      p "Finish seeding"

    end

    describe "Testing access to Hotels" do
      it "return unauthorized" do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end

      it "return authorized" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    describe "GET index" do
      it "Check GET status" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        get :index
        expect(response).to have_http_status(:ok)
      end

      it "List hotels" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        get :index
        hotels = JSON.parse(response.body)
        expect(hotels.size).to eq 2
        expect(hotels[0]["name"]).to eq("TestHotel1")
      end

      it "Show specific hotel" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        get :show, params: {id: @hotel1.id}
        hotels = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(hotels["email"]).to eq("cayala.w+testhotel1@gmail.com")
      end

      it "Check data of specific hotel" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        get :show, params: {id: @hotel1.id}
        hotel = JSON.parse(response.body)
        expect(hotel["name"]).to eq(@hotel1.name)
      end
    end

    describe "Add new hotel" do

      it "Add incorrect info for hotel" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        post :create, params: {name: "DummyHotel"}
        hotel = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(hotel["message"]).to eq("Hotel not saved")
      end

      it "Add hotel and check pos" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        post :create, params: {name: "TestHotel3", email: "cayala.w+testhotel3@gmail.com", city: "CityW", country: "CountryW", address: "Address for hotel TestHotel3" }
        hotel = JSON.parse(response.body)
        expect(response).to have_http_status(:ok) # check response
        expect(hotel["id"]).to eq(Hotel.last.id) # check if last creation is last.
      end
    end

    describe "Edit hotel" do
      it "Edit hotel and check id" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        patch :update, params: {id: Hotel.last.id, name: "TestHotelNamechange"}
        hotel = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(hotel["message"]).to eq("Updated hotel")
      end
    end

    describe "Delete hotel" do
      it "Delete hotel and check existence" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        delete :destroy, params: {id: Hotel.last.id}
        hotel = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(hotel["message"]).to eq("Hotel deleted")
      end
    end

  end
end
