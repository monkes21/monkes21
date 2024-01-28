##
##
##  check why gets included as image/png? is application/json?
##
## https://ordinals.com/inscription/47636105

###
# try hiro api
#  see https://docs.hiro.so/ordinals/introduction



$LOAD_PATH.unshift( "../pixelart/ordbase/ordinals/lib" )
require 'ordinals'
require 'ordlite'
require 'date'

OrdDb.open( './ord.db' )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"





def _parse_api( data )   ## parse api json data
    ## num via title
    attributes = {
     id:  data['id'],
     num: data['number'],
     bytes: data['content_length'], 
     sat:  data['sat_ordinal'],
     content_type:  data['content_type'],
     block: data['genesis_block_height'],
     fee: data['genesis_fee'].to_i(10),
     tx: data['genesis_tx_id'],
     address: data['address'],
     output: data['output'],
     value: data['value'].to_i(10),
     offset: data['offset'].to_i(10),
     # "2023-06-01 05:00:57 UTC"
     date:  Time.at( data['timestamp'] ).utc.to_datetime, 
   }
 
   attributes
 end
 

def _import_inscribe( data )
    Inscribe.create!( _parse_api( data ))
end



def import( from_number: nil, offset: nil )


=begin    
    if from_number.nil?
     from_number =  if Inscribe.count > 0 
                      Inscribe.maximum( :num )+1 
                   else 
                       45926920 
                   end
    end
=end

    puts "==> from_number #{from_number}..."


# {"limit"=>20, "offset"=>0, "total"=>0, "results"=>[]}
# 

    min_num = 999999999999
    max_num = 0
    text_count = 0
    image_count = 0
    png_count = 0


    loop do
      data =  Hiro.list( from_number: from_number, 
                              offset: offset )

        puts "  #{data['results'].size} result(s)"

        print "limit: ", data["limit"]
        print " offset: ", data["offset"]
        print " total: ",  data["total"]
        print "\n"
  
      if data['results'].size == 0
        puts "  results size == 0; breaking out of loop - reached the end?"
        pp data
        ## from_number += 60
        ##  puts "  sleeping in #{delay_in_s}s..."   
        ##  sleep( delay_in_s )
        ##  next
        break ## asume no more data
      end

      data['results'].each do |h|
         num            = h['number']
         content_type   = h['content_type']
         content_length = h['content_length']
 
         min_num = min_num > num ? num : min_num
         max_num = max_num < num ? num : max_num
       
         text_count  += 1  if content_type.downcase.start_with?( 'text/' ) 
         image_count += 1  if content_type.downcase.start_with?( 'image/' )
     

         if content_type.downcase.start_with?( 'image/png' ) &&
            content_length <= 467
            print " #{num}(#{content_length}b)"

            inscribe = Inscribe.find_by( num: num )
            if inscribe  ## already in db; dump record
              ## pp inscribe
            else         ## fetch via ordinals.com api and update db
                _import_inscribe( h )
            end

            png_count += 1
         else
            print " x(#{num})"
         end
       end
       print "\n"

    ## from_number = data['results'][-1]['number']
     offset = offset ? offset+60 : 60   
     puts " new offset: #{offset}"

     puts "  min: #{min_num}, max: #{max_num}"
     puts "  text: #{text_count}, image: #{image_count} (png: #{png_count})"
   end
end


## start at  block?
##  https://www.ord.io/47624293
##   note: maybe needs batch size round to floor?
##    start with some numbers back!!

## latest run
##  
## limit: 60 offset: 7020 total: 7064
##  new offset: 7080
##
## limit: 60 offset: 8280 total: 8326
##  new offset: 8340
##
## limit: 60 offset: 23340 total: 23448
##  new offset: 23400
##
## limit: 60 offset: 86400 total: 143321
##   new offset: 86460
##
##
## limit: 60 offset: 317700 total: 317819
##   new offset: 317760


## limit: 60 offset: 353880 total: 405082
##   new offset: 353940
##
## limit: 60 offset: 447960 total: 627058
##    new offset: 448020
##
## import( from_number: 47624000, offset: 353880 )   #  offset: 317700 ) 


###
#  2nd run starting at
#
#  limit: 60 offset: 117240 total: 159797
#    new offset: 117300
#
#  limit: 60 offset: 179280 total: 179348
#    new offset: 179340

##
## 3rd run starting at
##   49424458
#
#  limit: 60 offset: 64320 total: 64430
#      new offset: 64380
#
#  limit: 60 offset: 83280 total: 83345
#      new offset: 83340
#
#  limit: 60 offset: 89100 total: 89119
#     new offset: 89160

#
#  limit: 60 offset: 137880 total: 137978
#     new offset: 137940

#
#  limit: 60 offset: 158940 total: 159036
#    new offset: 159000


#
#  limit: 60 offset: 225180 total: 897866
#    new offset: 225240
#
#  limit: 60 offset: 386220 total: 962923
#    new offset: 386280
#
#  limit: 60 offset: 389400 total: 962923
#     new offset: 389460



import( from_number: 49424458, offset: 386220 ) 



puts "bye"

