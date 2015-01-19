class Bottle < ActiveRecord::Base
  belongs_to :wine
  accepts_nested_attributes_for :wine, :update_only => true
end
