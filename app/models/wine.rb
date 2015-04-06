class Wine < ActiveRecord::Base
  has_many :bottles, :dependent => :destroy

  paginates_per 12

  validates :vintage, :maturity, :drink_by,
            numericality: { only_integer: true, greater_than: 1899, less_than: 2101, allow_blank: true }

  validate :maturity_cannot_be_greater_than_or_equal_to_vintage

  validate :drink_by_cannot_be_greater_than_or_equal_to_vintage

  def maturity_cannot_be_greater_than_or_equal_to_vintage
    if vintage.present? && maturity.present? && maturity < vintage
      errors.add(:vintage, "can't be later than maturity")
    end
  end

  def drink_by_cannot_be_greater_than_or_equal_to_vintage
    if vintage.present? && drink_by.present? && drink_by < vintage
      errors.add(:vintage, "can't be later than drink_by")
    end
  end

  UNRANSACKABLE_ATTRIBUTES = %w[id created_at updated_at]
  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

end

