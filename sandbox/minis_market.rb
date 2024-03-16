require 'cocos'


meta = read_csv( './minis/minis.csv' )
puts "  #{meta.size} meta record(s)"

data = []


ids = (0..20).to_a
ids.each do |id|
    path = "./minis/hashcheck/#{id}.json"

    next unless File.exist?( path )

    ## get first inscription
    rec = read_json( path )['results'][0]
   
    

    spec = meta[ id ]
    type        = spec['type']
    accessories = (spec['attributes'] || '').split( '/' ).map {|attr| attr.strip }


    attributes = []
    attributes << { 'trait_type' => 'type',
                    'value'      => type }
    accessories.each do |acc|   ## change name to attribute (from accessory)
        attributes << { 'trait_type' => 'attribute',
                        'value'      => acc } 
    end
    attributes <<  { 'trait_type' => 'attribute count',
                     'value' => accessories.size.to_s }  ## number (type) possible?
    attributes <<  { 'trait_type' => 'style',
                     'value' =>  'minis (12px)' }
 
    data << {
               'id' => rec['inscriptionid'],
               'meta' => {
                 'name' => "Monke 12px \##{id}",
                 'attributes' => attributes
                }
            }

end


pp data


write_json( "./minis/inscriptions.json", data )

puts "bye"

