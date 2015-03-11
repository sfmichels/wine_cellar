#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'pp'
#require '../../app/models/wine'
#require 'active_record'

json = File.read('lib/scripts/wine_data.json')
wine_hashes = JSON.parse(json)

wine_hashes.each do |h|
  # some drink_by fields are marked as "Soon". Change them to this year. 2015.
  h['drink_by'] = 2015  if h['drink_by'] == 'soon'

  wine = Wine.find_or_create_by!(winery: h['winery'], variety: h['variety'], year: h['year'],
                                appellation: h['appellation'], vineyard: h['vineyard'], winemaker: h['winemaker'],
                                alcohol_content: h['alcohol_content'], color: h['color'], sparkling: h['sparkling'],
                                bottle_size: h['bottle_size'], country: h['country'], maturity: h['maturity'],
                                drink_by: h['drink_by'], dessert: h['dessert'])
end

