require 'rails_helper'

module Api
  RSpec.describe RoomsController, type: :controller do
    before(:each) do
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
      it "Respond with status ok" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        get :index
        rooms = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(rooms.size).to eq 4
      end

      it "List specific room" do # list specific element /api/albums/:id
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        get :show, params: {id: @room1.id}
        expect(response).to have_http_status(:ok)
      end

      it "Check data of specific booking" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        get :show, params: {id: @room2.id}
        room = JSON.parse(response.body)
        expect(room["price"]).to eq(@room2.price)
      end
    end

    describe "Add new room" do
      it "Add room, return error" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        post :create, params: {name: "DummyRoom1", amount_of_beds: 5, price: 300}
        room = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity) # check response
        expect(room["message"]).to eq("Room not saved") # check if last creation is last.
      end

      it "Add room, return ok" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        post :create, params: {name: "DummyRoom1", amount_of_beds: 5, price: 300, hotel_id: @hotel1}
        room = JSON.parse(response.body)
        expect(response).to have_http_status(:ok) # check response
        expect(room["id"]).to eq(Room.last.id) # check if last creation is last.
      end
    end

    describe "Edit room" do
      it "Edit room and check id" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        patch :update, params: {id: Room.last.id, name: "DummyRoom2"}
        room = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(room["message"]).to eq("Updated Room")
      end
    end

    describe "Delete room" do
      it "Delete room and check existance" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        delete :destroy, params: {id: Room.last.id}
        room = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(room["message"]).to eq("Room deleted")
      end
    end
=begin
    describe "Booking rooms" do
      it "Booking room" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        post :book, params: {room_id: @room1.id, start_date: Date.today + 10, end_date: Date.today + 12, paid_price: @room1.price, user_id: @user2.id}
        booking  =JSON.parse(response.body)
        expect(response).to have_ttp_status(:ok)
        expect(booking["id"]).to eq(Booking.last.id)
      end

      it "Booking conflicts" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        post :book, params: {room_id: @room1.id, start_date: Date.today + 1, end_date: Date.today, paid_price: @room1.price, user_id: @user2.id}
        booking  =JSON.parse(response.body)
        expect(response).to have_ttp_status(:ok)
        expect(booking["message"]).to eq("booking conflicts")
      end

      it "Reject booking" do
        request.headers['Authorization'] = "Token token=#{@user2.token}" # adding access permission
        post :book, params: {room_id: @room1.id, start_date: Date.today + 10, paid_price: @room1.price, user_id: @user2.id}
        booking  =JSON.parse(response.body)
        expect(response).to have_ttp_status(:ok)
        expect(booking["message"]).to eq("not enough params")
      end
    end
=end
  end
end
