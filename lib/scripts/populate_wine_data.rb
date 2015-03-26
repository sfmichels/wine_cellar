#!/usr/bin/env ruby
require 'rubygems'
require 'json'
require 'date'

# Read jason data
json = File.read('lib/scripts/wine_test_data.json')

# Replace vertical tab from filemaker with a new line
json.gsub!(/\v/, '\n')

# Maturity should only have one year
# Some records looked like:  "maturity":"2008-2020 "
# Remove the hyphen, the second year and the space after the second date.
json.gsub!(/("maturity":")(\d{4})(\-[\d]{4} ")/, '\1\2"')

wine_hashes = JSON.parse(json)

wine_hashes.each do |h|

  # Some drink_by fields are marked as "Soon". Change them to this year, 2015.
  # Empty strings in json need to be converted to nil
  if h['drink_by'] == 'soon'
    h['drink_by'] = 2015
  elsif h['drink_by'] == ""
    h['drink_by'] = nil
  end

  # Empty strings in json need to be converted to nil
  h['year'] = nil if h['year'] == ""
  h['maturity'] = nil if h['maturity'] == ""

  puts "Winery: #{h['winery']}, Variety: #{h['variety']}"
  # Create a record for a wine once
  wine = Wine.where(winery: h['winery'], variety: h['variety'], year: h['year'],
                    appellation: h['appellation'], vineyard: h['vineyard'], winemaker: h['winemaker'],
                    alcohol_content: h['alcohol_content'], color: h['color'], sparkling: h['sparkling'],
                    bottle_size: h['bottle_size'], country: h['country'], maturity: h['maturity'],
                    drink_by: h['drink_by'], dessert: h['dessert']).first_or_create!

  # add the first my_notes and other_notes attributes
  must_update = false
  if wine.my_notes.blank? && h['my_notes'].present?
    wine.my_notes = h['my_notes']
    must_update = true
  end
  if wine.other_notes.blank? && h['other_notes'].present?
    wine.other_notes = h['other_notes']
    must_update = true
  end
  wine.save if must_update

  # set value using month/day/year format coming in from json
  h['consumed_date'] = Date.strptime(h['consumed_date'], "%m/%d/%Y") if h['consumed_date'].to_s != ''
  h['purchase_date'] = Date.strptime(h['purchase_date'], "%m/%d/%Y") if h['purchase_date'].to_s != ''

  # add bottle
  bottle = Bottle.create(purchased_from: h['purchased_from'], purchase_price: h['purchase_price'],
                         location: h['location'], purchase_date: h['purchase_date'],
                         consumed_date: h['consumed_date'], wine_id: wine.id)
end


