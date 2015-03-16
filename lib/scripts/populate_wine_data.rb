#!/usr/bin/env ruby
require 'rubygems'
require 'json'
require 'date'

json = File.read('lib/scripts/wine_test_data.json')
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

  wine = Wine.where(winery: h['winery'], variety: h['variety'], year: h['year'],
                    appellation: h['appellation'], vineyard: h['vineyard'], winemaker: h['winemaker'],
                    alcohol_content: h['alcohol_content'], color: h['color'], sparkling: h['sparkling'],
                    bottle_size: h['bottle_size'], country: h['country'], maturity: h['maturity'],
                    drink_by: h['drink_by'], dessert: h['dessert'],
                    my_notes: h['my_notes'], other_notes: h['other_notes']).first_or_create

  # set value using month/day/year format coming in from json
  h['consumed_date'] = Date.strptime(h['consumed_date'] , "%m/%d/%Y") if h['consumed_date'].to_s != ''
  h['purchased_date'] = Date.strptime(h['purchased_date'] , "%m/%d/%Y") if h['purchased_date'].to_s != ''


  bottle = Bottle.create(purchased_from: h['purchased_from'], purchase_price: h['purchase_price'],
                         location: h['location'], purchase_date: h['purchase_date'],
                         consumed_date: h['consumed_date'], wine_id: wine.id)
end

