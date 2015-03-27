class Wine < ActiveRecord::Base
  has_many :bottles, :dependent => :destroy

  paginates_per 12

  validates :year, :maturity, :drink_by,
            numericality: { only_integer: true, greater_than: 1899, less_than: 2101, allow_blank: true }

  validate :maturity_cannot_be_greater_than_or_equal_to_year

  validate :drink_by_cannot_be_greater_than_or_equal_to_year

  def maturity_cannot_be_greater_than_or_equal_to_year
    if year.present? && maturity.present? && maturity < year
      errors.add(:year, "can't be later than maturity")
    end
  end

  def drink_by_cannot_be_greater_than_or_equal_to_year
    if year.present? && drink_by.present? && drink_by < year
      errors.add(:year, "can't be later than drink_by")
    end
  end

  UNRANSACKABLE_ATTRIBUTES = %w[id created_at updated_at]
  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

end

