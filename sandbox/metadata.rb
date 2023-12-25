####
## assemble metadata for monkes21; to run use:
##
##   $ ruby sandbox/metadata.rb


require 'cocos'


meta = read_csv( '../monkesee-monkedo/monkesee-monkedo.csv' )
puts "  #{meta.size} meta record(s)"
## cut-off at 2000
meta = meta[0,20000]
puts "  #{meta.size} meta record(s)"

moremeta = read_csv( '../letsrock/letsrock.csv' )
puts "  #{moremeta.size} meta record(s)"

## prefix type with rock!
moremeta = moremeta.map do |rec| 
               rec['type'] = "rock #{rec['type']}"
               rec['id'] = (rec['id'].to_i(10)+20000).to_s
               rec 
          end
meta += moremeta
puts "  #{meta.size} meta record(s)"



headers = ['id', 'type', 'attributes', 'background']
buf = ""
buf << headers.join( ', ' )
buf << "\n"
meta.each do |rec|
   buf << rec.values.join( ', ' )
   buf << "\n"
end 

write_text( "monkes21.csv", buf)


puts "bye"

