class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :email
      t.string :city
      t.string :country
      t.string :address

      t.timestamps
    end
  end
end
