class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :amount_of_beds
      t.integer :price
      t.references :hotel, foreign_key: true

      t.timestamps
    end
  end
end
