#!/usr/bin/env ruby
require 'rubygems'
require 'json'
require 'date'
require 'wine'

# Read jason data
def populate_from_json_file
  json = File.read('lib/scripts/wine_data.json')
  populate_wine_data json
end


def populate_wine_data json

# Replace vertical tab from filemaker with a new line
  json.gsub!(/\v/, '\n')

# Maturity should only have one year
# Some records looked like:  "maturity":"2008-2020 "
# Remove the hyphen, the second year and the space after the second date.
  json.gsub! /(\"maturity\": )(\"\d{4})(-\d{4} )(\")/, '\1\2\4'

  wine_hashes = JSON.parse(json)

  wine_hashes.each do |h|

    # Some drink_by fields are marked as "Soon". Change them to this year, 2015.
    # Empty strings in json need to be converted to nil
    if h['drink_by'] == ""
      h['drink_by'] = nil
    elsif h['drink_by'].downcase == 'soon'
      h['drink_by'] = 2015
    end

    # Empty strings in json need to be converted to nil
    h['vintage'] = nil if h['vintage'] == ""
    h['vintage_displayer'] = h['vintage']
    h['vintage'] = nil
    h['maturity'] = nil if h['maturity'] == ""

    puts "Winery: #{h['winery']}, Variety: #{h['variety']}, Vintage: #{h['vintage_displayer']}"

    # Create a record for a wine once
    wine = Wine.new(winery: h['winery'], variety: h['variety'], vintage: h['vintage'],
                    non_vintage: h['non_vintage'], vintage_displayer: h['vintage_displayer'],
                    appellation: h['appellation'], vineyard: h['vineyard'], winemaker: h['winemaker'],
                    alcohol_content: h['alcohol_content'], color: h['color'], sparkling: h['sparkling'],
                    bottle_size: h['bottle_size'], country: h['country'], maturity: h['maturity'],
                    drink_by: h['drink_by'], dessert: h['dessert'])
    puts wine.inspect

    wine.set_vintage_nonvintage
    puts wine.inspect

    wine = Wine.where(winery: h['winery'], variety: h['variety'], vintage: wine.vintage,
               non_vintage: wine.non_vintage, vintage_displayer: wine.vintage_displayer,
               appellation: h['appellation'], vineyard: h['vineyard'], winemaker: h['winemaker'],
               alcohol_content: h['alcohol_content'], color: h['color'], sparkling: h['sparkling'],
               bottle_size: h['bottle_size'], country: h['country'], maturity: h['maturity'],
               drink_by: h['drink_by'], dessert: h['dessert']).first_or_create!
    wine.inspect

    # add the first my_notes and other_notes attributes
    if wine.my_notes.blank? && h['my_notes'].present?
      wine.update_attribute(:my_notes, h['my_notes'])
    end
    if wine.other_notes.blank? && h['other_notes'].present?
      wine.update_attribute(:other_notes, h['other_notes'])
    end

    wine.inspect

    # set value using month/day/year format coming in from json
    h['consumed_date'] = Date.strptime(h['consumed_date'], "%m/%d/%Y") if !h['consumed_date'].to_s.empty?
    h['purchase_date'] = Date.strptime(h['purchase_date'], "%m/%d/%Y") if !h['purchase_date'].to_s.empty?

    # add bottle
    puts "Add a bottle"
    bottle = Bottle.create(purchased_from: h['purchased_from'], purchase_price: h['purchase_price'],
                           location: h['location'], purchase_date: h['purchase_date'],
                           consumed_date: h['consumed_date'], wine_id: wine.id)
  end
end

populate_from_json_file
