require 'ordlite'
require 'date'


OrdDb.open( '../hiro2/ord.db' )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"



recs = read_csv( '../orc721/market/monkes21/mint.csv' )
puts "  #{recs.size} record(s)"

meta = read_csv( '../monkesee-monkedo/monkesee-monkedo.csv' )
puts "  #{meta.size} meta record(s)"
## cut-off at 2000
meta = meta[0,20000]

moremeta = read_csv( '../letsrock/letsrock.csv' )
puts "  #{meta.size} meta record(s)"

## prefix type with rock!
moremeta = moremeta.map { |rec| rec['type'] = "rock #{rec['type']}"; rec }
meta += moremeta



data = []

recs = recs.sort { |l,r|  l['ref'].to_i <=> r['ref'].to_i }


recs.each_with_index do |rec,i|

    print "."  if i %10 == 0

    num     = rec['num'].to_i
    ref     = rec['ref'].to_i

    offset = if num >= 49139176  ## fix: find when switch happend?
               2
            else  ## assume assume  one
               1
            end

    ## note: hiro num is SMALLER (by -1/-2) !!!!
    hiro_num = num - offset

 
    inscribe = Inscribe.find_by( num: hiro_num )


    spec = meta[ ref ]
    background = spec['background']
    type       = spec['type']
    accessories = (spec['accessories'] || '').split( '/' ).map {|acc| acc.strip }
 
    attributes = []
    attributes << { 'trait_type' => 'type',
                    'value'      => type }
    accessories.each do |acc|   ## change name to attribute (from accessory)
        attributes << { 'trait_type' => 'attribute',
                        'value'      => acc } 
    end
    attributes <<  { 'trait_type' => 'attribute count',
                     'value' => accessories.size.to_s }  ## number (type) possible?
    attributes <<  { 'trait_type' => 'background',
                     'value' =>  background }
 

    data << {
               'id' => inscribe.id,
               'meta' => {
                 'name' => "Monke Twenty One \##{ref}",
                 'attributes' => attributes
                }
            }
end
print "\n"


write_json( "./tmp/inscriptions.json", data )

puts "bye"

