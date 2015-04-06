class ChangevintageToVintage < ActiveRecord::Migration
  def change
    rename_column :wines, :vintage, :vintage
    add_column :wines, :non_vintage, :boolean
  end
end
