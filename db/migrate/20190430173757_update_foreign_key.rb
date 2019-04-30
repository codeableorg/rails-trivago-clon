class UpdateForeignKey < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :bookings, :users
    remove_foreign_key :bookings, :rooms
    add_foreign_key :bookings, :users, on_delete: :cascade
    add_foreign_key :bookings, :rooms, on_delete: :cascade
  end
end
