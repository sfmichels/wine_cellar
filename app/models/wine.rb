class Wine < ActiveRecord::Base
  has_many :bottles, :dependent => :destroy
  belongs_to :user

  paginates_per 12

  before_validation :set_vintage_nonvintage

  after_validation :drink_by_cannot_be_greater_than_or_equal_to_vintage

  validates :vintage, :maturity, :drink_by,
            numericality: {only_integer: true, greater_than: 1899, less_than: 2101, allow_blank: true}

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

  def set_vintage_nonvintage
    self.vintage = nil
    self.non_vintage = nil
    if self.vintage_displayer.nil? || self.vintage_displayer == ""
      self.non_vintage = nil
      self.vintage = nil
    elsif self.vintage_displayer.is_a? String and ["NV", "NON VINTAGE", "NON-VINTAGE"].include? self.vintage_displayer.upcase
      self.non_vintage = true
      self.vintage_displayer = "NV"
    else
      vintage = Integer(self.vintage_displayer) rescue nil
      if !vintage.nil?
        if vintage > 1899 && vintage < 2101
          self.non_vintage = false
          self.vintage = vintage
          self.vintage_displayer = vintage.to_s
        else
          errors.add(:vintage, "can't be before 1900 or after 2100")
        end
      else
        errors.add(:vintage, "illegal value for vintage")
      end
    end
  end
end
