class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :winery
      t.string :variety
      t.integer :year
      t.string :appellation
      t.string :vineyard
      t.string :winemaker
      t.string :alcohol_content
      t.string :color
      t.boolean :sparkling
      t.string :bottle_size
      t.string :country
      t.integer :maturity
      t.integer :drink_by

      t.timestamps
    end
  end
end
