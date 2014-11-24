class CreateBottles < ActiveRecord::Migration
  def change
    create_table :bottles do |t|
      t.string :purchased_from
      t.decimal :purchase_price, precision: 9, scale: 2
      t.date :purchase_date
      t.string :location
      t.date :consumed_date
      t.references :wine, index: true

      t.timestamps
    end
  end
end
