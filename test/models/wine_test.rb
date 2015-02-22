require 'test_helper'

class WineTest < ActiveSupport::TestCase

  def setup
    @wine = Wine.new
  end

  [:year, :maturity, :drink_by].each do |atr|

    test "should save the wine if #{atr} is from 1900 to 2100" do
      @wine.send("#{atr}=", 1988)

      assert @wine.valid?
    end

    test "should not save a wine if #{atr} is a string" do
      @wine.send("#{atr}=", "dog")

      assert_not @wine.valid?
    end

    test "should not save a wine if #{atr} is a fractional decimal" do
      @wine.send("#{atr}=", 2014.5)

      assert_not @wine.valid?
    end

    test "should not save wine if #{atr} is less than 1900" do
      @wine.send("#{atr}=", 1899)

      assert_not @wine.valid?
    end

    test "should not save wine if #{atr} is greater than 2100" do
      @wine.send("#{atr}=", 2101)

      assert_not @wine.valid?
    end

    test " can save wine if #{atr} can be blank" do
      @wine.send("#{atr}=", nil)

      assert @wine.valid?
    end
  end

  test "not valid if maturity is less than than year" do
    @wine.maturity = 2012
    @wine.year = 2013

    assert_not @wine.valid?
  end

  test "should validate wine if maturity is equal to year" do
    @wine.maturity = 2012
    @wine.year = 2012

    assert @wine.valid?
  end

  test "should validate wine if maturity is greater than year" do
    @wine.maturity = 2012
    @wine.year = 2011

    assert @wine.valid?
  end

  test "not valid if drink by is less than than year" do
    @wine.drink_by = 2012
    @wine.year = 2013

    assert_not @wine.valid?
  end

  test "should validate wine if drink by is equal to year" do
    @wine.drink_by = 2012
    @wine.year = 2012

    assert @wine.valid?
  end

  test "should validate wine if drink by is greater than year" do
    @wine.drink_by = 2012
    @wine.year = 2011

    assert @wine.valid?
  end

end



