require 'test_helper'

class WineTest < ActiveSupport::TestCase

  def setup
    @wine = Wine.new
  end

  test "should save the wine if vintage is from 1900 to 2100" do
    @wine.vintage_displayer = "1988"

    assert @wine.valid?
    assert_equal 1988, @wine.vintage
    assert !@wine.non_vintage
  end

  test "should not save a wine if vintage is a string, not a number, not a non-vintage" do
    @wine.vintage_displayer = "dog"

    assert_not @wine.valid?
  end

  test "should not save a wine if vintage is a fractional decimal" do
    @wine.vintage_displayer = "2014.5"

    assert_not @wine.valid?
  end

  test "should not save wine if vintage is less than 1900" do
    @wine.vintage_displayer = "1899"

    assert_not @wine.valid?
  end

  test "should not save wine if vintage is greater than 2100" do
    @wine.vintage_displayer = "2101"

    assert_not @wine.valid?
  end

  test "can save wine if vintage is blank" do
    @wine.vintage_displayer = nil

    assert @wine.valid?
    assert @wine.vintage.nil?
    assert @wine.non_vintage.nil?
  end



[:maturity, :drink_by].each do |atr|
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

    test " can save wine if #{atr} is blank" do
      @wine.send("#{atr}=", nil)

      assert @wine.valid?
    end
  end

  test "not valid if maturity is less than vintage" do
    @wine.maturity = 2012
    @wine.vintage_displayer = "2013"

    assert_not @wine.valid?
  end

  test "should validate wine if maturity is equal to vintage" do
    @wine.maturity = 2012
    @wine.vintage_displayer = "2012"

    assert @wine.valid?
  end

  test "should validate wine if maturity is greater than vintage" do
    @wine.maturity = 2012
    @wine.vintage_displayer = "2011"

    assert @wine.valid?
  end

  test "not valid if drink by is less than than vintage" do
    @wine.drink_by = 2012
    @wine.vintage_displayer = "2013"

    assert_not @wine.valid?
  end

  test "should validate wine if drink by is equal to vintage" do
    @wine.drink_by = 2012
    @wine.vintage_displayer = "2012"

    assert @wine.valid?
  end

  test "should validate wine if drink by is greater than vintage" do
    @wine.drink_by = 2012
    @wine.vintage_displayer = "2011"

    assert @wine.valid?
  end

  # various tests for the different ways to enter non-vintage

  test "should save the wine and set nv to nil " do
    @wine.vintage_displayer = nil

    assert @wine.valid?
    assert @wine.vintage.nil?
    assert @wine.non_vintage.nil?
  end

  test "should save the wine if vintage is nv " do
    @wine.vintage_displayer = "nv"

    assert @wine.valid?
    assert_nil @wine.vintage = nil
    assert @wine.non_vintage
  end

  test "should save the wine if vintage is ' NV' " do
    @wine.vintage_displayer = "NV"

    assert @wine.valid?
    assert_nil @wine.vintage
    assert @wine.non_vintage = true
  end

  test "should save the wine if vintage is 'non-vintage' " do
    @wine.vintage_displayer = "nv"

    assert @wine.valid?
    assert_nil @wine.vintage
    assert @wine.non_vintage = true
  end

  test "should save the wine if vintage is 'NON-VINTAGE' " do
    @wine.vintage_displayer = "nv"

    assert @wine.valid?
    assert_nil @wine.vintage
    assert @wine.non_vintage = true
  end

  test "should save the wine if vintage is 'non vintage' " do
    @wine.vintage_displayer = "nv"

    assert @wine.valid?
    assert_nil @wine.vintage
    assert @wine.non_vintage = true
  end

  test "should save the wine if vintage is 'NON VINTAGE' " do
    @wine.vintage_displayer = "nv"

    assert @wine.valid?
    assert_nil @wine.vintage
    assert @wine.non_vintage = true
  end



end



