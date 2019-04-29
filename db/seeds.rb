# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
require 'faker'

p "Seeding DB"
p "Adding images"
# Add images for rooms
#



# Add images for hotels
#

# Add users
#
p "Adding 5 users and 5 admin"
user1 = User.create(name: Faker::Name.unique.name, email: "imadeyvi+user@gmail.com", password: "123456")
user2 = User.create(name: Faker::Name.unique.name, email: "cesarcachay1996+user@gmail.com", password: "123456")
user3 = User.create(name: Faker::Name.unique.name, email: "cayala.w+user@gmail.com", password: "123456")
user4 = User.create(name: Faker::Name.unique.name, email: "cristian.granda.pastor+user@gmail.com", password: "123456")
user5 = User.create(name: Faker::Name.unique.name, email: "ry.yrupailla+user@gmail.com", password: "123456")
User.create(name: Faker::Name.unique.name, email: "imadeyvi+admin@gmail.com", password: "123456", role: "admin")
User.create(name: Faker::Name.unique.name, email: "cesarcachay1996+admin@gmail.com", password: "123456", role: "admin")
User.create(name: Faker::Name.unique.name, email: "cayala.w+admin@gmail.com", password: "123456", role: "admin")
User.create(name: Faker::Name.unique.name, email: "cristian.granda.pastor+admin@gmail.com", password: "123456", role: "admin")
User.create(name: Faker::Name.unique.name, email: "ry.yrupailla+admin@gmail.com", password: "123456", role: "admin")

# Add Hotel
p "Adding 5 hotels"
hotel1 = Hotel.create(name: Faker::Company.unique.name, email: "madeyvi+hotel@gmail.com", city: Faker::Address.city, country: Faker::Address.country, address: Faker::Address.full_address)
hotel2 = Hotel.create(name: Faker::Company.unique.name, email: "cesarcachay1996+hotel@gmail.com", city: Faker::Address.city, country: Faker::Address.country, address: Faker::Address.full_address)
hotel3 = Hotel.create(name: Faker::Company.unique.name, email: "cayala.w+hotel@gmail.com", city: Faker::Address.city, country: Faker::Address.country, address: Faker::Address.full_address)
hotel4 = Hotel.create(name: Faker::Company.unique.name, email: "cristian.granda.pastor+hotel@gmail.com", city: Faker::Address.city, country: Faker::Address.country, address: Faker::Address.full_address)
hotel5 = Hotel.create(name: Faker::Company.unique.name, email: "ry.yrupailla+hotel@gmail.com", city: Faker::Address.city, country: Faker::Address.country, address: Faker::Address.full_address)

# Add rooms
# Check relation room with hotel
p "Adding 10 rooms"
room1 = Room.create(name: Faker::Name.name, amount_of_beds: rand(1..4), hotel_id: 1, price: rand(50..300))
# room1.hotel << hotel1
room2 = Room.create(name: Faker::Name.name, amount_of_beds: rand(1..4), hotel_id: 1, price: rand(50..300))
# room2.hotel << hotel1
room3 = Room.create(name: Faker::Name.name, amount_of_beds: rand(1..4), hotel_id: 2, price: rand(50..300))
# room3.hotel << hotel2
room4 = Room.create(name: Faker::Name.name, amount_of_beds: rand(1..4), hotel_id: 2, price: rand(50..300))
# room4.hotel << hotel2
room5 = Room.create(name: Faker::Name.name, amount_of_beds: rand(1..4), hotel_id: 3, price: rand(50..300))
# room5.hotel << hotel3
room6 = Room.create(name: Faker::Name.name, amount_of_beds: rand(1..4), hotel_id: 3, price: rand(50..300))
# room6.hotel << hotel3
room7 = Room.create(name: Faker::Name.name, amount_of_beds: rand(1..4), hotel_id: 4, price: rand(50..300))
# room7.hotel << hotel4
room8 = Room.create(name: Faker::Name.name, amount_of_beds: rand(1..4), hotel_id: 4, price: rand(50..300))
# room8.hotel << hotel4
room9 = Room.create(name: Faker::Name.name, amount_of_beds: rand(1..4), hotel_id: 5, price: rand(50..300))
# room9.hotel << hotel5
room10 = Room.create(name: Faker::Name.name, amount_of_beds: rand(1..4), hotel_id: 5, price: rand(50..300))
# room10.hotel << hotel5

# Add 3 bookings
# Check relation booking with room and user
p "Adding 3 bookings"

book1 = Booking.create(start_date: Date.parse("May 8 2018"), end_date: Date.parse("May 10 2018"), user_id: 1, room_id: 1, paid_price: room1.price)
# book1.room << room1
# book1.user << user1
book2 = Booking.create(start_date: Date.parse("April 10 2018"), end_date: Date.parse("April 15 2018"), user_id: 3, room_id: 1, paid_price: room4.price)
# book2.room << room4
# book1.user << user3
book3 = Booking.create(start_date: Date.parse("October 23 2018"), end_date: Date.parse("October 23 2018"), user_id: 5, room_id: 1, paid_price: room6.price)
# book3.room << room6
# book3.user << user5

# Add promotions
p "Adding 4 promotions"
# Check relation promotion with room and hotel
promotion1 = Promotion.create(start_date: Date.parse("January 15 2019"), end_date: Date.parse("April 15 2019"), discount_type: "Percentage", discount_amount: 5, promotionable_type: "Hotel", promotionable_id: 1)
# promotion1.hotel << hotel1
promotion2 = Promotion.create(start_date: Date.parse("February 10 2019"), end_date: Date.parse("February 17 2019"), discount_type: "Fixed", discount_amount: 30, promotionable_type: "Room", promotionable_id: 3)
# promotion2.room << room3
promotion3 = Promotion.create(start_date: Date.parse("May 15 2019"), end_date: Date.parse("June 15 2019"), discount_type: "Percentage", discount_amount: 9, promotionable_type: "Room", promotionable_id: 5)
# promotion1.room << room5

