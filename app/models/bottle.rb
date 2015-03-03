class Bottle < ActiveRecord::Base
  belongs_to :wine
  accepts_nested_attributes_for :wine, :update_only => true

  UNRANSACKABLE_ATTRIBUTES = %w[id created_at updated_at wine_id]
  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
