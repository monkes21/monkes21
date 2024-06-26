###
# merge all special collection editions 

require 'cocos'

data = []


data += read_json( './rocklines/inscriptions.json' )
data += read_json( './sketches/inscriptions.json' )
data += read_json( './minis/inscriptions.json' )
data += read_json( './goldcoins/inscriptions.json' )
data += read_json( './pennies/inscriptions.json' )

puts "  #{data.size} inscription record(s)"


write_json( "./tmp/specials/inscriptions.json", data )

puts "bye"
