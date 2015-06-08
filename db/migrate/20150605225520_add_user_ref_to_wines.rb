class AddUserRefToWines < ActiveRecord::Migration
  def change
    add_reference :wines, :user, index: true, foreign_key: true
  end
end
