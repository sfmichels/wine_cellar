class AddDessertToWine < ActiveRecord::Migration
  def change
    add_column :wines, :dessert, :boolean
  end
end
