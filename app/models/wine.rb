class Wine < ActiveRecord::Base
  has_many :bottles, :dependent => :destroy
end
