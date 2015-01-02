module BottlesHelper
  # Returns a formatted date or nil
  def date_or_nil(date)
    date.nil? ? nil : date.strftime("%x")
  end
end
