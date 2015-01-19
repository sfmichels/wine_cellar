class Wine < ActiveRecord::Base
  has_many :bottles, :dependent => :destroy
  #accepts_nested_attributes_for :bottles, :allow_destroy => true
end
