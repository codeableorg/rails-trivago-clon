class CreatePromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.date :start_date
      t.date :end_date
      t.string :discount_type
      t.integer :discount_amount
      t.references :promotionable, polymorphic: true

      t.timestamps
    end
  end
end
