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

def get_image(file_name)
  { io: File.open(File.join(Rails.root, "/app/assets/images/#{file_name}")), filename: file_name }
end

# Add images for hotels
#

# Add users
#
p "Adding 5 users and 5 admin"
# User.create(name: Faker::Name.unique.name, email: "iamdeyvi+admin@gmail.com", password: "123456", role: "admin")
User.create(name: Faker::Name.unique.name, email: "cesarcachay1996+admin@gmail.com", password: "123456", role: "admin")
# User.create(name: Faker::Name.unique.name, email: "cayala.w+admin@gmail.com", password: "123456", role: "admin")
# User.create(name: Faker::Name.unique.name, email: "cristian.granda.pastor+admin@gmail.com", password: "123456", role: "admin")
# User.create(name: Faker::Name.unique.name, email: "ry.yrupailla+admin@gmail.com", password: "123456", role: "admin")
user1 = User.create(name: Faker::Name.unique.name, email: "iamdeyvi+user@gmail.com", password: "123456")
user2 = User.create(name: Faker::Name.unique.name, email: "cesarcachay1996+user@gmail.com", password: "123456")
user3 = User.create(name: Faker::Name.unique.name, email: "cayala.w+user@gmail.com", password: "123456")
user4 = User.create(name: Faker::Name.unique.name, email: "cristian.granda.pastor+user@gmail.com", password: "123456")
user5 = User.create(name: Faker::Name.unique.name, email: "ry.yrupailla+user@gmail.com", password: "123456")

# Add Hotel
p "Adding 5 hotels"
hotel1 = Hotel.create(name: Faker::Company.unique.name, email: "iamdeyvi+hotel@gmail.com", city: Faker::Address.city, country: Faker::Address.country, address: Faker::Address.full_address, cover: get_image("hotels/hotel1.jpg"))
hotel2 = Hotel.create(name: Faker::Company.unique.name, email: "cesarcachay1996+hotel@gmail.com", city: Faker::Address.city, country: Faker::Address.country, address: Faker::Address.full_address, cover: get_image("hotels/hotel2.jpg"))
hotel3 = Hotel.create(name: Faker::Company.unique.name, email: "cayala.w+hotel@gmail.com", city: Faker::Address.city, country: Faker::Address.country, address: Faker::Address.full_address, cover: get_image("hotels/hotel3.jpg"))
hotel4 = Hotel.create(name: Faker::Company.unique.name, email: "cristian.granda.pastor+hotel@gmail.com", city: Faker::Address.city, country: Faker::Address.country, address: Faker::Address.full_address, cover: get_image("hotels/hotel4.jpg"))
hotel5 = Hotel.create(name: Faker::Company.unique.name, email: "ry.yrupailla+hotel@gmail.com", city: Faker::Address.city, country: Faker::Address.country, address: Faker::Address.full_address, cover: get_image("hotels/hotel5.jpg"))

# Add rooms
p "Adding 10 rooms"
room1 = hotel1.rooms.create(name: Faker::Name.name, amount_of_beds: rand(1..4), price: rand(50..300), cover: get_image("rooms/room1.jpg"))
room2 = hotel1.rooms.create(name: Faker::Name.name, amount_of_beds: rand(1..4), price: rand(50..300), cover: get_image("rooms/room2.jpg"))
room3 = hotel2.rooms.create(name: Faker::Name.name, amount_of_beds: rand(1..4), price: rand(50..300), cover: get_image("rooms/room3.jpg"))
room4 = hotel2.rooms.create(name: Faker::Name.name, amount_of_beds: rand(1..4), price: rand(50..300), cover: get_image("rooms/room4.jpg"))
room5 = hotel3.rooms.create(name: Faker::Name.name, amount_of_beds: rand(1..4), price: rand(50..300), cover: get_image("rooms/room5.jpg"))
room6 = hotel3.rooms.create(name: Faker::Name.name, amount_of_beds: rand(1..4), price: rand(50..300), cover: get_image("rooms/room1.jpg"))
room7 = hotel4.rooms.create(name: Faker::Name.name, amount_of_beds: rand(1..4), price: rand(50..300), cover: get_image("rooms/room2.jpg"))
room8 = hotel4.rooms.create(name: Faker::Name.name, amount_of_beds: rand(1..4), price: rand(50..300), cover: get_image("rooms/room3.jpg"))
room9 = hotel5.rooms.create(name: Faker::Name.name, amount_of_beds: rand(1..4), price: rand(50..300), cover: get_image("rooms/room4.jpg"))
room10 = hotel5.rooms.create(name: Faker::Name.name, amount_of_beds: rand(1..4), price: rand(50..300), cover: get_image("rooms/room5.jpg"))


# Add 3 bookings
# Check relation booking with room and user
p "Adding 3 bookings"
book1 = user1.bookings.create!(start_date: Date.today, end_date: Date.today + 1.days, paid_price: room1.price, room_id: 1)
user1.bookings.create!(start_date: Date.today + 3, end_date: Date.today + 5.days, paid_price: room1.price, room_id: 1)
# book1.rooms << room1
book2 = user2.bookings.create!(start_date: Date.parse("April 10 2018"), end_date: Date.parse("April 15 2018"), paid_price: room4.price, room_id: 4)
# book2.rooms << room4
book3 = user5.bookings.create!(start_date: Date.parse("October 23 2018"), end_date: Date.parse("October 23 2018"), paid_price: room6.price, room_id: 6)
# book3.rooms << room6

# Add promotions
p "Adding 4 promotions"
# Check relation promotion with room and hotel
promotion1 = hotel1.promotions.create(start_date: Date.parse("January 15 2019"), end_date: Date.parse("April 15 2019"), discount_type: "Percentage", discount_amount: 5)
# promotion1.hotel << hotel1
promotion2 = room3.promotions.create(start_date: Date.parse("February 10 2019"), end_date: Date.parse("February 17 2019"), discount_type: "Fixed", discount_amount: 30)
# promotion2.room << room3
promotion3 = room5.promotions.create(start_date: Date.parse("May 15 2019"), end_date: Date.parse("June 15 2019"), discount_type: "Percentage", discount_amount: 9)
# promotion1.room << room5

