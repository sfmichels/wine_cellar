require 'test_helper'

class WineTest < ActiveSupport::TestCase

  test "should save the wine if year is from 1900 to 2100" do
    wine = Wine.new
    wine.year = 1988

    assert wine.save
  end

  test "should not save a wine if it is a string" do
    wine = Wine.new
    wine.year = "dog"

    assert_not wine.save
  end

  test "should not save a wine if it is a decimal" do
    wine = Wine.new
    wine.year = 2014.5

    assert_not wine.save
  end

  test "should not save wine if year is less than 1900" do
    wine = Wine.new
    wine.year = 1899

    assert_not wine.save
  end

  test "should not save wine if year is greater than 2100" do
    wine = Wine.new
    wine.year = 2101

    assert_not wine.save
  end

  test "the year can be blank" do
    wine = Wine.new
    wine.year = nil

    assert wine.save
  end

end
