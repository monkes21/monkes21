###
# merge all special collection editions 

require 'cocos'

data = []


data += read_json( './rocklines/inscriptions.json' )
data += read_json( './sketches/inscriptions.json' )

puts "  #{data.size} inscription record(s)"


write_json( "./tmp/specials/inscriptions.json", data )

puts "bye"
