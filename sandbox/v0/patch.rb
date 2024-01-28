require 'cocos'

require 'digest'

$LOAD_PATH.unshift( "../pixelart/ordbase/ordinals/lib" )
require 'ordinals'
require 'ordlite'
require 'date'



## try to set wait to 0.3 secs
Ordinals.config.delay_in_s  = 0.3



##  "title": "Inscription 9992615",
 TITLE_RX = /^Inscription (?<num>[0-9]+)$/i
 
 def title_to_num( str )
    if m=TITLE_RX.match( str )
       m[:num].to_i(10)    ## use base 10
    else
      puts "!! ERROR - no inscribe num found in title >#{str}<"
      exit 1   ## not found - raise exception - why? why not?
    end
 end
 


def write_ids( path, ids )
  ####
  # save/write out id mappings/check
  puts "   #{ids.size} id(s)"

  headers = ['id', 'num', 'hiro']
  buf = ""
  buf << headers.join( ', ' )
  buf << "\n"
  ids.each do |values|
    buf << values.join( ', ' )
    buf << "\n"
  end 

  write_text( path, buf)
end




OrdDb.open( './ord.db' )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"


recs = read_csv( "./ids.csv" )
puts "   #{recs.size} id records"
recs += read_csv( "./ids.more.csv")
puts "   #{recs.size} id records"

batches = [2,3,4,5,6]
batches.each do |batch|
  recs += read_csv( "./ids.#{batch}.csv" )
end

morepath = "./ids.#{batches[-1]+1}.csv"


## make a backup copy (to restore if anything happens)
blob = read_blob( "./ids.csv" )
write_blob( "./tmp/ids_#{Time.now.utc.to_i}.csv", blob )

ids_by_content = recs.reduce( {} ) do |h, rec|
                                       h[ rec['id']] = rec['num'].to_i(10)
                                       h
                                   end

ids = []  ## new records to save
moreids = []  ## more ids to cache and snapshot save 





oldmints = read_csv( "./oldmint.csv" )
puts "   #{oldmints.size} old mint records"

### reverse sort (newest first)
oldmints = oldmints.sort { |l,r| r['num'].to_i(10) <=> l['num'].to_i(10) }



mints = []  ## new patched mint records to save


## first check all mint records have content monke files exported

ups = 0

oldmints.each_with_index do |oldmint, i|
  inscribe = Inscribe.find_by( num: oldmint['num']) 
  puts "==> #{i+1}/#{oldmints.size}..."
  if inscribe.nil?
    puts "!! ERROR - missing in inscribe in db, sorry"
    exit 1
  end

  num = ids_by_content[ inscribe.id ]
  if num.nil?
     ups += 1
     ## fetching metadata via ordinals.com api
     data = Ordinals.inscription( inscribe.id )
     pp data

    ## double check content type
    if data['content-type'] != 'image/png'
      puts "!! ERROR - image/png content type expected; sorry"
      exit 1
    end

    num = title_to_num( data['title'] )

    moreids << [inscribe.id, num.to_s, inscribe.num.to_s]
    ## back-up in case of crash every 50 updates
    write_ids( morepath, moreids )     if ups > 1 && ups % 50 == 0
  end  

  ids << [inscribe.id, num.to_s, inscribe.num.to_s]
  mints << [num.to_s, oldmint['ref']]
end



write_ids( "./ids.csv", ids )

####
# save/write out patched mint records
# pp mints
puts "   #{mints.size} mint(s)"

headers = ['num', 'ref']
buf = ""
buf << headers.join( ', ' )
buf << "\n"
mints.each do |values|
   buf << values.join( ', ' )
   buf << "\n"
end 

write_text( "mint.csv", buf)



puts "bye"


