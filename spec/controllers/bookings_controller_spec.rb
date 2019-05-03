require 'rails_helper'

module Api
  RSpec.describe BookinsController, type: :controller do
    before(:each) do
      Bookings.delete_all
      Rooms.delete_all
      Hotels.delete_all
      Sessions.delete_all # required?

      @user1 = User.create(name: "User1Admin", email: "cayala.w+testadmin@gmail.com", role: "admin") # admin
      @user2 = User.create(name: "User2Regular", email: "cayala.w+testuser1@gmail.com") # user      
      @user3 = User.create(name: "User3Regular", email: "cayala.w+testuser2@gmail.com")
      
      @hotel1 = Hotel.create(name: "TestHotel1", email: "cayala.w+testhotel1@gmail.com", city: "City Z", country: "CountryZ", address: "Address for hotel TestHotel1")
      @hotal2 = Hotel.create(name: "TestHotel2", email: "cayala.w+testhotel2@gmail.com", city: "City B", country: "CountryB", address: "Address for hotel TestHotel2")

      @room1 = @hotel1.rooms.create(name: "Room1Hotel1", amount_of_beds: 2, price: 100)
      @room2 = @hotel1.rooms.create(name: "Room2Hotel1", amount_of_beds: 3, price: 200)
      @room3 = @hotel2.rooms.create(name: "Room1Hotel2", amount_of_beds: 2, price: 80)
      @room4 = @hotel2.rooms.create(name: "Room2Hotel2", amount_of_beds: 3, price: 120)

      @book1 = @user2.bookings.create(start_date: Date.parse("May 5 2019"), end_date: Date.parse("May 8 2019"), paid_price: @room1.price, room_id: @room1.id)
      @book2 = @user3.bookings.create(start_date: Date.parse("May 6 2019"), end_date: Date.parse("May 7 2019"), paid_price: @room2.price, room_id: @room2.id)

      @promo1 = @hotel1.promotions.create(start_date: Date.parse("May 15 2019"), end_date: Date.parse("June 14 2019"), discount_type: "Percentage", discount_amount: 5)
      @promo2 = @room2.promotions.create(start_date: Date.parse("May 6 2019"), end_date: Date.parse("May 13 2019"), discount_type: "Fixed", discount_amount: 10)

    end

    describe "GET index" do
      it "Respond with status ok" do
        get :index
        expect(response).to have_http_status(:ok)
      end
      it "List bookings" do
        get :index
        bookings = JSON.parse(response.body)
        expect(bookings.size).to eq 1
        expect(bookings[0][""].to eq(""))
      end
      it "List specific booking" do # list specific element /api/albums/:id
        get :show, params: {id: @book1.id}
        expect(response).to have_http_status(:ok)
      end
      it "Check data of specific booking" do
        get :show, params: {id: @book2.id}
        book = JSON.parse(response.body)
        expect(book["paid_price"]).to eq(@book2.price)
      end
    end

    describe "Add new booking" do
      it "Add book and is last" do
        post :new, params: {start_date:Date.parse("May 2 2019"), end_date:Date.parse("May 5 2019"), paid_price: @room3.price, user_id: @user3.id, room_id: @room3.id }
        book = JSON.parse(response.body)
        expect(response).to have_http_status(:ok) # check response
        expect(book["id"]).to eq(Book.last.id) # check if last creation is last.
      end
    end
    describe "Edit booking" do
      it "Edit booking and check id" do
        patch :edit, params: {id: Book.last.id, start_date: Date.parse("July 1 2019"), end_date: Date.parse("July 2 2019")}
        book = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(book["id"]).to eq(Book.last.id)
      end
    end

  end
end
