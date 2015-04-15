class AddVintageDisplayer < ActiveRecord::Migration
  def change
    add_column(:wines, :vintage_displayer, :string)
  end
end
