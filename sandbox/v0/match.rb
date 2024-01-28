require 'cocos'

require 'digest'




require_relative 'base'   ## build HASHES lookup/table


##
# get minted images

files = Dir.glob( "./monkes/*.png" )
puts "  #{files.size} file(s)"

## make sure files are sorted
files = files.sort


mapping = []
more_mapping = []   ## add overflow


files.each_with_index do |file,i|

   inscribe_num = File.basename( file, File.extname(file) ).to_i(10)
   puts "==> #{i} - #{inscribe_num} =>  ..."
   blob = read_blob( file )
   image_hash = Digest::SHA256.hexdigest( blob )
   pp image_hash
 
   monke_nums = HASHES[ image_hash ]
   pp monke_nums

   if monke_nums.empty?
      puts "!! overflow mint @ #{inscribe_num}"
      more_mapping << [ inscribe_num, HASHES_FIRST[ image_hash] ]
   else
      mapping << [ inscribe_num, monke_nums.shift ]
   end
end


## pp mapping


headers = ['num', 'ref']
buf = ""
buf << headers.join( ', ' )
buf << "\n"
mapping.each do |values|
   buf << values.join( ', ' )
   buf << "\n"
end 

write_text( "oldmint.csv", buf)



## pp more_mapping


headers = ['num', 'ref']
buf = ""
buf << headers.join( ', ' )
buf << "\n"
more_mapping.each do |values|
   buf << values.join( ', ' )
   buf << "\n"
end 

write_text( "oldmint.more.csv", buf)



puts "   #{mapping.size} monke(s)"
puts "   #{more_mapping.size} more monke(s)"

puts "bye"
