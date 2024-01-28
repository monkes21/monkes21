require 'cocos'

require 'digest'

$LOAD_PATH.unshift( "../pixelart/ordbase/ordinals/lib" )
require 'ordinals'
require 'ordlite'
require 'date'




OrdDb.open( './ord.db' )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"


Inscribe.order( 'num DESC' ).limit(10).each do |inscribe|
   puts "  #{inscribe.num} " 
end



require_relative 'base'    ## build HASHES lookup/table


MONKES = []


## try to set wait to 0.3 secs
Ordinals.config.delay_in_s  = 0.3


Inscribe.order( 'num' ).each do |inscribe|

   if File.exist?( "./monkes/#{inscribe.num}.png" )
      MONKES << inscribe.num  
   elsif File.exist?( "./other/#{inscribe.num}.png" )
      ## skip
   else  ## download and image check
  content = Ordinals.content( inscribe.id )
  ## pp content

  image_hash = Digest::SHA256.hexdigest( content.data )
  pp image_hash

  monke_nums = HASHES[ image_hash ]

  if monke_nums
     puts " bingo!!"
     write_blob( "./monkes/#{inscribe.num}.png", content.data )
     MONKES << inscribe.num
  else
     puts "    x(#{inscribe.num})"
     write_blob( "./other/#{inscribe.num}.png", content.data )
  end
end
end


## pp MONKES
puts "   #{MONKES.size} monke(s)"

puts "bye"
