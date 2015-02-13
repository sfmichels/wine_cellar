class AddAttributesToWines < ActiveRecord::Migration
  def change
    add_column :wines, :my_notes, :text
    add_column :wines, :other_notes, :text
  end
end
