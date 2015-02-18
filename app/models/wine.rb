class Wine < ActiveRecord::Base
  has_many :bottles, :dependent => :destroy

  validates :year, :maturity, :drink_by,
            numericality: { only_integer: true, greater_than: 1899, less_than: 2101, allow_blank: true }

end
